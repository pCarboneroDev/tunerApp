package com.example.tuner_app

import android.Manifest
import android.media.AudioFormat
import android.media.AudioRecord
import android.media.MediaRecorder
import androidx.annotation.RequiresPermission
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity(){
    private val CHANNEL = "com.example.recordAudio"
    private val sampleRate = 44100
    private val bufferSize = 16384
    private var audioRecord: AudioRecord? = null

    @RequiresPermission(Manifest.permission.RECORD_AUDIO)
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "startAudioRecord" -> {

                        var args = call.arguments as List<*>
                        Thread {
                            var a = startAudioRecord(args[0] as Boolean)
                            runOnUiThread {
                                result.success(a)
                            }
                        }.start()
                    }
                    "stopAudioRecord" -> {
                        //stopAudioRecord()
                        Thread {
                            stopAudioRecord()
                            runOnUiThread {
                                result.success(null)
                            }
                        }.start()
                    }
                    else -> result.notImplemented()
                }
            }
    }

    @RequiresPermission(Manifest.permission.RECORD_AUDIO)
    private fun startAudioRecord(isRecording: Boolean): Double {
        var freq = 0.0
        // Aquí va tu implementación con AudioRecord
        if (audioRecord == null) init()

        if(audioRecord != null){
            audioRecord!!.startRecording()
            while (isRecording){
                freq = processYIN(audioRecord!!, bufferSize, sampleRate)
            }
            audioRecord?.stop()
        }

        return freq
    }

    private fun stopAudioRecord() {
        audioRecord?.stop()
    }

    @RequiresPermission(Manifest.permission.RECORD_AUDIO)
    private fun init(){
        audioRecord = AudioRecord(
            MediaRecorder.AudioSource.MIC, sampleRate,
            AudioFormat.CHANNEL_IN_MONO, AudioFormat.ENCODING_PCM_16BIT, bufferSize
        )
    }


    private fun processYIN(audioRecord: AudioRecord, bufferSize: Int, sampleRate: Int): Double {
        // se crea un array de shorts del tamaño del número de muestras que se pueden capturar
        val buffer = ShortArray(bufferSize)
        // se comprueba si audio record tiene muestras capturadas, si no devuelkve 0
        val numOfSamples = audioRecord.read(buffer, 0, bufferSize)
        if (numOfSamples <= 0) return 0.0

        //  convierte los valores detectados a double para mejorar la precisión
        val signal = DoubleArray(numOfSamples) { buffer[it].toDouble() }

        // se configuran la frecuencia máxima y mínima detectables
        // tau es la latencia entre muestras (τ)
        val tauMin = sampleRate / 2000 // 500 hz
        val tauMax = sampleRate / 20 // 50 hz (creo)

        val differenceFunction = DoubleArray(tauMax)
        val cumulativeMeanNormalizedDifferenceFunction = DoubleArray(tauMax)


        // se mide la diferencia entre la señal y su versión mas avanzada en el tiempo
        // cuanto menor la diferencia mas probable de que haya una frecuencia fundamental
        // de esta forma se pueden ignorar los armónicos de las notas
        for (tau in tauMin until tauMax) {
            var sum = 0.0
            for (i in 0 until (numOfSamples - tau)) {
                val diff = signal[i] - signal[i + tau]
                sum += diff * diff
            }
            differenceFunction[tau] = sum
        }

        // se normaliza para que sea mas preciso
        cumulativeMeanNormalizedDifferenceFunction[0] = 1.0
        // se divide cada valor entre la suma de los valores de tau
        // se hace para evitar latencias muy cortas
        for (tau in 1 until tauMax) {
            var sum = 0.0
            for (j in 1..tau) {
                sum += differenceFunction[j]
            }
            cumulativeMeanNormalizedDifferenceFunction[tau] =
                if (sum == 0.0) 1.0 else differenceFunction[tau] / (sum / tau)
        }

        // se busca el primer valle por debajo del umbral
        // si el valle es menor 0.1 es la frecuencia fundamental, es decir,
        // que el periodo de la onda se repite,
        // por lo que es la frecuencia de la nota principal en el momento
        //
        val threshold = 0.1
        var tauEstimate = -1
        var aux = 0
        for (tau in tauMin until tauMax) {
            aux = tau
            if (cumulativeMeanNormalizedDifferenceFunction[tau] < threshold) {
                while (aux + 1 < tauMax && cumulativeMeanNormalizedDifferenceFunction[aux + 1] < cumulativeMeanNormalizedDifferenceFunction[aux]) {
                    aux++
                }
                tauEstimate = aux
                break
            }
        }
        // se sigue la fórmula f = samplerate/tau
        var f = 0.0

        if (tauEstimate != -1){
            f = sampleRate.toDouble()/tauEstimate
        }

        return f
    }
}

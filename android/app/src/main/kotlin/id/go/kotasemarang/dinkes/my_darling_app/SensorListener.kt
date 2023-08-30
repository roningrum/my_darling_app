package id.go.kotasemarang.dinkes.my_darling_app

import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener

class WalkSensorListener(onNewData: (value: Int) -> Unit) : SensorEventListener {
    private lateinit var onNewData : (value: Int)->Unit
    override fun onSensorChanged(event: SensorEvent?) {
        if(event == null){
            return
        }
        onNewData(event.values[0].toInt())
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {
    }
}
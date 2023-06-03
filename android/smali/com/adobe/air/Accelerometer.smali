.class public Lcom/adobe/air/Accelerometer;
.super Ljava/lang/Object;
.source "Accelerometer.java"

# interfaces
.implements Landroid/hardware/SensorEventListener;


# static fields
.field private static final STANDARD_GRAVITY:F = 9.81f


# instance fields
.field private mContext:Landroid/content/Context;

.field private mSensorManager:Landroid/hardware/SensorManager;

.field private m_x:F

.field private m_y:F

.field private m_z:F


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v2, 0x1

    .line 46
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 47
    iput-object p1, p0, Lcom/adobe/air/Accelerometer;->mContext:Landroid/content/Context;

    .line 48
    iget-object v0, p0, Lcom/adobe/air/Accelerometer;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    const-string v1, "android.hardware.sensor.accelerometer"

    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v0

    if-ne v0, v2, :cond_0

    .line 50
    const-string v0, "sensor"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/SensorManager;

    iput-object v0, p0, Lcom/adobe/air/Accelerometer;->mSensorManager:Landroid/hardware/SensorManager;

    .line 51
    iget-object v0, p0, Lcom/adobe/air/Accelerometer;->mSensorManager:Landroid/hardware/SensorManager;

    iget-object v1, p0, Lcom/adobe/air/Accelerometer;->mSensorManager:Landroid/hardware/SensorManager;

    invoke-virtual {v1, v2}, Landroid/hardware/SensorManager;->getDefaultSensor(I)Landroid/hardware/Sensor;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, p0, v1, v2}, Landroid/hardware/SensorManager;->registerListener(Landroid/hardware/SensorEventListener;Landroid/hardware/Sensor;I)Z

    .line 53
    :cond_0
    return-void
.end method


# virtual methods
.method public getX()F
    .locals 1

    .prologue
    .line 35
    iget v0, p0, Lcom/adobe/air/Accelerometer;->m_x:F

    return v0
.end method

.method public getY()F
    .locals 1

    .prologue
    .line 39
    iget v0, p0, Lcom/adobe/air/Accelerometer;->m_y:F

    return v0
.end method

.method public getZ()F
    .locals 1

    .prologue
    .line 43
    iget v0, p0, Lcom/adobe/air/Accelerometer;->m_z:F

    return v0
.end method

.method public onAccuracyChanged(Landroid/hardware/Sensor;I)V
    .locals 0
    .param p1, "sensor"    # Landroid/hardware/Sensor;
    .param p2, "accuracy"    # I

    .prologue
    .line 25
    return-void
.end method

.method public onSensorChanged(Landroid/hardware/SensorEvent;)V
    .locals 3
    .param p1, "se"    # Landroid/hardware/SensorEvent;

    .prologue
    const v2, 0x411cf5c3    # 9.81f

    .line 18
    iget-object v0, p1, Landroid/hardware/SensorEvent;->values:[F

    const/4 v1, 0x0

    aget v0, v0, v1

    div-float/2addr v0, v2

    iput v0, p0, Lcom/adobe/air/Accelerometer;->m_x:F

    .line 19
    iget-object v0, p1, Landroid/hardware/SensorEvent;->values:[F

    const/4 v1, 0x1

    aget v0, v0, v1

    div-float/2addr v0, v2

    iput v0, p0, Lcom/adobe/air/Accelerometer;->m_y:F

    .line 20
    iget-object v0, p1, Landroid/hardware/SensorEvent;->values:[F

    const/4 v1, 0x2

    aget v0, v0, v1

    div-float/2addr v0, v2

    iput v0, p0, Lcom/adobe/air/Accelerometer;->m_z:F

    .line 21
    return-void
.end method

.method public removeListener()V
    .locals 2

    .prologue
    .line 28
    iget-object v0, p0, Lcom/adobe/air/Accelerometer;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    const-string v1, "android.hardware.sensor.accelerometer"

    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 30
    iget-object v0, p0, Lcom/adobe/air/Accelerometer;->mSensorManager:Landroid/hardware/SensorManager;

    invoke-virtual {v0, p0}, Landroid/hardware/SensorManager;->unregisterListener(Landroid/hardware/SensorEventListener;)V

    .line 32
    :cond_0
    return-void
.end method

.class public Lcom/adobe/air/DeviceRotation;
.super Ljava/lang/Object;
.source "DeviceRotation.java"

# interfaces
.implements Landroid/hardware/SensorEventListener;


# instance fields
.field private mContext:Landroid/content/Context;

.field private mSensorManager:Landroid/hardware/SensorManager;

.field private m_pitch:F

.field private m_quaternion_data:[F

.field private m_roll:F

.field private m_yaw:F


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 160
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 20
    const/4 v0, 0x4

    new-array v0, v0, [F

    iput-object v0, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    .line 161
    iput-object p1, p0, Lcom/adobe/air/DeviceRotation;->mContext:Landroid/content/Context;

    .line 162
    invoke-direct {p0}, Lcom/adobe/air/DeviceRotation;->hasRequiredSensors()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 164
    iget-object v0, p0, Lcom/adobe/air/DeviceRotation;->mContext:Landroid/content/Context;

    const-string v1, "sensor"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/SensorManager;

    iput-object v0, p0, Lcom/adobe/air/DeviceRotation;->mSensorManager:Landroid/hardware/SensorManager;

    .line 165
    iget-object v0, p0, Lcom/adobe/air/DeviceRotation;->mSensorManager:Landroid/hardware/SensorManager;

    iget-object v1, p0, Lcom/adobe/air/DeviceRotation;->mSensorManager:Landroid/hardware/SensorManager;

    const/16 v2, 0xf

    invoke-virtual {v1, v2}, Landroid/hardware/SensorManager;->getDefaultSensor(I)Landroid/hardware/Sensor;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, p0, v1, v2}, Landroid/hardware/SensorManager;->registerListener(Landroid/hardware/SensorEventListener;Landroid/hardware/Sensor;I)Z

    .line 167
    :cond_0
    return-void
.end method

.method private hasRequiredSensors()Z
    .locals 3

    .prologue
    const/4 v0, 0x1

    .line 170
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x12

    if-lt v1, v2, :cond_0

    iget-object v1, p0, Lcom/adobe/air/DeviceRotation;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    const-string v2, "android.hardware.sensor.accelerometer"

    invoke-virtual {v1, v2}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v1

    if-ne v1, v0, :cond_0

    iget-object v1, p0, Lcom/adobe/air/DeviceRotation;->mContext:Landroid/content/Context;

    .line 171
    invoke-virtual {v1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    const-string v2, "android.hardware.sensor.gyroscope"

    invoke-virtual {v1, v2}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v1

    if-ne v1, v0, :cond_0

    .line 170
    :goto_0
    return v0

    .line 171
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private recalculateQuaternion(FFF)[F
    .locals 12
    .param p1, "_pitch"    # F
    .param p2, "_roll"    # F
    .param p3, "_yaw"    # F

    .prologue
    .line 103
    float-to-double v4, p1

    invoke-static {v4, v5}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v4

    double-to-float v2, v4

    .line 104
    .local v2, "roll":F
    float-to-double v4, p2

    invoke-static {v4, v5}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v4

    double-to-float v0, v4

    .line 105
    .local v0, "pitch":F
    float-to-double v4, p3

    invoke-static {v4, v5}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v4

    double-to-float v3, v4

    .line 107
    .local v3, "yaw":F
    const/4 v4, 0x4

    new-array v1, v4, [F

    .line 109
    .local v1, "quat":[F
    const/4 v4, 0x0

    const/high16 v5, 0x40000000    # 2.0f

    div-float v5, v2, v5

    float-to-double v6, v5

    invoke-static {v6, v7}, Ljava/lang/Math;->cos(D)D

    move-result-wide v6

    const/high16 v5, 0x40000000    # 2.0f

    div-float v5, v0, v5

    float-to-double v8, v5

    invoke-static {v8, v9}, Ljava/lang/Math;->cos(D)D

    move-result-wide v8

    mul-double/2addr v6, v8

    const/high16 v5, 0x40000000    # 2.0f

    div-float v5, v3, v5

    float-to-double v8, v5

    invoke-static {v8, v9}, Ljava/lang/Math;->cos(D)D

    move-result-wide v8

    mul-double/2addr v6, v8

    const/high16 v5, 0x40000000    # 2.0f

    div-float v5, v2, v5

    float-to-double v8, v5

    invoke-static {v8, v9}, Ljava/lang/Math;->sin(D)D

    move-result-wide v8

    const/high16 v5, 0x40000000    # 2.0f

    div-float v5, v0, v5

    float-to-double v10, v5

    invoke-static {v10, v11}, Ljava/lang/Math;->sin(D)D

    move-result-wide v10

    mul-double/2addr v8, v10

    const/high16 v5, 0x40000000    # 2.0f

    div-float v5, v3, v5

    float-to-double v10, v5

    invoke-static {v10, v11}, Ljava/lang/Math;->sin(D)D

    move-result-wide v10

    mul-double/2addr v8, v10

    add-double/2addr v6, v8

    double-to-float v5, v6

    aput v5, v1, v4

    .line 110
    const/4 v4, 0x1

    const/high16 v5, 0x40000000    # 2.0f

    div-float v5, v2, v5

    float-to-double v6, v5

    invoke-static {v6, v7}, Ljava/lang/Math;->sin(D)D

    move-result-wide v6

    const/high16 v5, 0x40000000    # 2.0f

    div-float v5, v0, v5

    float-to-double v8, v5

    invoke-static {v8, v9}, Ljava/lang/Math;->cos(D)D

    move-result-wide v8

    mul-double/2addr v6, v8

    const/high16 v5, 0x40000000    # 2.0f

    div-float v5, v3, v5

    float-to-double v8, v5

    invoke-static {v8, v9}, Ljava/lang/Math;->cos(D)D

    move-result-wide v8

    mul-double/2addr v6, v8

    const/high16 v5, 0x40000000    # 2.0f

    div-float v5, v2, v5

    float-to-double v8, v5

    invoke-static {v8, v9}, Ljava/lang/Math;->cos(D)D

    move-result-wide v8

    const/high16 v5, 0x40000000    # 2.0f

    div-float v5, v0, v5

    float-to-double v10, v5

    invoke-static {v10, v11}, Ljava/lang/Math;->sin(D)D

    move-result-wide v10

    mul-double/2addr v8, v10

    const/high16 v5, 0x40000000    # 2.0f

    div-float v5, v3, v5

    float-to-double v10, v5

    invoke-static {v10, v11}, Ljava/lang/Math;->sin(D)D

    move-result-wide v10

    mul-double/2addr v8, v10

    sub-double/2addr v6, v8

    double-to-float v5, v6

    aput v5, v1, v4

    .line 111
    const/4 v4, 0x2

    const/high16 v5, 0x40000000    # 2.0f

    div-float v5, v2, v5

    float-to-double v6, v5

    invoke-static {v6, v7}, Ljava/lang/Math;->cos(D)D

    move-result-wide v6

    const/high16 v5, 0x40000000    # 2.0f

    div-float v5, v0, v5

    float-to-double v8, v5

    invoke-static {v8, v9}, Ljava/lang/Math;->sin(D)D

    move-result-wide v8

    mul-double/2addr v6, v8

    const/high16 v5, 0x40000000    # 2.0f

    div-float v5, v3, v5

    float-to-double v8, v5

    invoke-static {v8, v9}, Ljava/lang/Math;->cos(D)D

    move-result-wide v8

    mul-double/2addr v6, v8

    const/high16 v5, 0x40000000    # 2.0f

    div-float v5, v2, v5

    float-to-double v8, v5

    invoke-static {v8, v9}, Ljava/lang/Math;->sin(D)D

    move-result-wide v8

    const/high16 v5, 0x40000000    # 2.0f

    div-float v5, v0, v5

    float-to-double v10, v5

    invoke-static {v10, v11}, Ljava/lang/Math;->cos(D)D

    move-result-wide v10

    mul-double/2addr v8, v10

    const/high16 v5, 0x40000000    # 2.0f

    div-float v5, v3, v5

    float-to-double v10, v5

    invoke-static {v10, v11}, Ljava/lang/Math;->sin(D)D

    move-result-wide v10

    mul-double/2addr v8, v10

    add-double/2addr v6, v8

    double-to-float v5, v6

    aput v5, v1, v4

    .line 112
    const/4 v4, 0x3

    const/high16 v5, 0x40000000    # 2.0f

    div-float v5, v2, v5

    float-to-double v6, v5

    invoke-static {v6, v7}, Ljava/lang/Math;->cos(D)D

    move-result-wide v6

    const/high16 v5, 0x40000000    # 2.0f

    div-float v5, v0, v5

    float-to-double v8, v5

    invoke-static {v8, v9}, Ljava/lang/Math;->cos(D)D

    move-result-wide v8

    mul-double/2addr v6, v8

    const/high16 v5, 0x40000000    # 2.0f

    div-float v5, v3, v5

    float-to-double v8, v5

    invoke-static {v8, v9}, Ljava/lang/Math;->sin(D)D

    move-result-wide v8

    mul-double/2addr v6, v8

    const/high16 v5, 0x40000000    # 2.0f

    div-float v5, v2, v5

    float-to-double v8, v5

    invoke-static {v8, v9}, Ljava/lang/Math;->sin(D)D

    move-result-wide v8

    const/high16 v5, 0x40000000    # 2.0f

    div-float v5, v0, v5

    float-to-double v10, v5

    invoke-static {v10, v11}, Ljava/lang/Math;->sin(D)D

    move-result-wide v10

    mul-double/2addr v8, v10

    const/high16 v5, 0x40000000    # 2.0f

    div-float v5, v3, v5

    float-to-double v10, v5

    invoke-static {v10, v11}, Ljava/lang/Math;->cos(D)D

    move-result-wide v10

    mul-double/2addr v8, v10

    sub-double/2addr v6, v8

    double-to-float v5, v6

    aput v5, v1, v4

    .line 114
    return-object v1
.end method


# virtual methods
.method public getPitch()F
    .locals 1

    .prologue
    .line 137
    iget v0, p0, Lcom/adobe/air/DeviceRotation;->m_pitch:F

    return v0
.end method

.method public getQuaternionData()[F
    .locals 1

    .prologue
    .line 157
    iget-object v0, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    return-object v0
.end method

.method public getRoll()F
    .locals 1

    .prologue
    .line 129
    iget v0, p0, Lcom/adobe/air/DeviceRotation;->m_roll:F

    return v0
.end method

.method public getW()F
    .locals 2

    .prologue
    .line 141
    iget-object v0, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v1, 0x0

    aget v0, v0, v1

    return v0
.end method

.method public getX()F
    .locals 2

    .prologue
    .line 145
    iget-object v0, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v1, 0x1

    aget v0, v0, v1

    return v0
.end method

.method public getY()F
    .locals 2

    .prologue
    .line 149
    iget-object v0, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v1, 0x2

    aget v0, v0, v1

    return v0
.end method

.method public getYaw()F
    .locals 1

    .prologue
    .line 133
    iget v0, p0, Lcom/adobe/air/DeviceRotation;->m_yaw:F

    return v0
.end method

.method public getZ()F
    .locals 2

    .prologue
    .line 153
    iget-object v0, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v1, 0x3

    aget v0, v0, v1

    return v0
.end method

.method public onAccuracyChanged(Landroid/hardware/Sensor;I)V
    .locals 0
    .param p1, "sensor"    # Landroid/hardware/Sensor;
    .param p2, "accuracy"    # I

    .prologue
    .line 119
    return-void
.end method

.method public onSensorChanged(Landroid/hardware/SensorEvent;)V
    .locals 13
    .param p1, "se"    # Landroid/hardware/SensorEvent;

    .prologue
    .line 24
    iget-object v7, p1, Landroid/hardware/SensorEvent;->sensor:Landroid/hardware/Sensor;

    invoke-virtual {v7}, Landroid/hardware/Sensor;->getType()I

    move-result v7

    const/16 v8, 0xf

    if-ne v7, v8, :cond_0

    .line 26
    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->mContext:Landroid/content/Context;

    iget-object v8, p0, Lcom/adobe/air/DeviceRotation;->mContext:Landroid/content/Context;

    const-string v8, "window"

    invoke-virtual {v7, v8}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Landroid/view/WindowManager;

    invoke-interface {v7}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v7

    invoke-virtual {v7}, Landroid/view/Display;->getRotation()I

    move-result v1

    .line 27
    .local v1, "orientation":I
    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->mSensorManager:Landroid/hardware/SensorManager;

    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    iget-object v8, p1, Landroid/hardware/SensorEvent;->values:[F

    invoke-static {v7, v8}, Landroid/hardware/SensorManager;->getQuaternionFromVector([F[F)V

    .line 29
    const/4 v7, 0x4

    new-array v6, v7, [F

    .line 31
    .local v6, "tempQuat":[F
    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v8, 0x4

    invoke-static {v7, v8}, Ljava/util/Arrays;->copyOf([FI)[F

    move-result-object v6

    .line 33
    const/4 v2, 0x0

    .line 34
    .local v2, "q0":F
    const/4 v3, 0x0

    .line 35
    .local v3, "q1":F
    const/4 v4, 0x0

    .line 36
    .local v4, "q2":F
    const/4 v5, 0x0

    .line 39
    .local v5, "q3":F
    packed-switch v1, :pswitch_data_0

    .line 84
    :goto_0
    const/4 v7, 0x3

    if-eq v1, v7, :cond_0

    .line 86
    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v8, 0x0

    aget v2, v7, v8

    .line 87
    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v8, 0x1

    aget v3, v7, v8

    .line 88
    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v8, 0x2

    aget v4, v7, v8

    .line 89
    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v8, 0x3

    aget v5, v7, v8

    .line 92
    const/high16 v7, 0x40000000    # 2.0f

    mul-float v8, v2, v3

    mul-float v9, v4, v5

    add-float/2addr v8, v9

    mul-float/2addr v7, v8

    float-to-double v8, v7

    const/high16 v7, 0x3f800000    # 1.0f

    const/high16 v10, 0x40000000    # 2.0f

    mul-float v11, v3, v3

    mul-float v12, v4, v4

    add-float/2addr v11, v12

    mul-float/2addr v10, v11

    sub-float/2addr v7, v10

    float-to-double v10, v7

    invoke-static {v8, v9, v10, v11}, Ljava/lang/Math;->atan2(DD)D

    move-result-wide v8

    invoke-static {v8, v9}, Ljava/lang/Math;->toDegrees(D)D

    move-result-wide v8

    double-to-float v7, v8

    iput v7, p0, Lcom/adobe/air/DeviceRotation;->m_pitch:F

    .line 93
    const/high16 v7, 0x40000000    # 2.0f

    mul-float v8, v2, v4

    mul-float v9, v5, v3

    sub-float/2addr v8, v9

    mul-float/2addr v7, v8

    float-to-double v8, v7

    invoke-static {v8, v9}, Ljava/lang/Math;->asin(D)D

    move-result-wide v8

    invoke-static {v8, v9}, Ljava/lang/Math;->toDegrees(D)D

    move-result-wide v8

    double-to-float v7, v8

    iput v7, p0, Lcom/adobe/air/DeviceRotation;->m_roll:F

    .line 94
    const/high16 v7, 0x40000000    # 2.0f

    mul-float v8, v2, v5

    mul-float v9, v3, v4

    add-float/2addr v8, v9

    mul-float/2addr v7, v8

    float-to-double v8, v7

    const/high16 v7, 0x3f800000    # 1.0f

    const/high16 v10, 0x40000000    # 2.0f

    mul-float v11, v4, v4

    mul-float v12, v5, v5

    add-float/2addr v11, v12

    mul-float/2addr v10, v11

    sub-float/2addr v7, v10

    float-to-double v10, v7

    invoke-static {v8, v9, v10, v11}, Ljava/lang/Math;->atan2(DD)D

    move-result-wide v8

    invoke-static {v8, v9}, Ljava/lang/Math;->toDegrees(D)D

    move-result-wide v8

    double-to-float v7, v8

    iput v7, p0, Lcom/adobe/air/DeviceRotation;->m_yaw:F

    .line 98
    .end local v1    # "orientation":I
    .end local v2    # "q0":F
    .end local v3    # "q1":F
    .end local v4    # "q2":F
    .end local v5    # "q3":F
    .end local v6    # "tempQuat":[F
    :cond_0
    return-void

    .line 41
    .restart local v1    # "orientation":I
    .restart local v2    # "q0":F
    .restart local v3    # "q1":F
    .restart local v4    # "q2":F
    .restart local v5    # "q3":F
    .restart local v6    # "tempQuat":[F
    :pswitch_0
    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v8, 0x1

    const/4 v9, 0x1

    aget v9, v6, v9

    aput v9, v7, v8

    .line 42
    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v8, 0x2

    const/4 v9, 0x2

    aget v9, v6, v9

    aput v9, v7, v8

    .line 43
    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v8, 0x3

    const/4 v9, 0x3

    aget v9, v6, v9

    aput v9, v7, v8

    goto/16 :goto_0

    .line 46
    :pswitch_1
    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v8, 0x1

    const/4 v9, 0x2

    aget v9, v6, v9

    neg-float v9, v9

    aput v9, v7, v8

    .line 47
    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v8, 0x2

    const/4 v9, 0x1

    aget v9, v6, v9

    aput v9, v7, v8

    .line 48
    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v8, 0x3

    const/4 v9, 0x3

    aget v9, v6, v9

    aput v9, v7, v8

    goto/16 :goto_0

    .line 53
    :pswitch_2
    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v8, 0x1

    const/4 v9, 0x1

    aget v9, v6, v9

    neg-float v9, v9

    aput v9, v7, v8

    .line 54
    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v8, 0x2

    const/4 v9, 0x2

    aget v9, v6, v9

    neg-float v9, v9

    aput v9, v7, v8

    .line 55
    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v8, 0x3

    const/4 v9, 0x3

    aget v9, v6, v9

    aput v9, v7, v8

    goto/16 :goto_0

    .line 60
    :pswitch_3
    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v8, 0x1

    const/4 v9, 0x2

    aget v9, v6, v9

    aput v9, v7, v8

    .line 61
    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v8, 0x2

    const/4 v9, 0x1

    aget v9, v6, v9

    neg-float v9, v9

    aput v9, v7, v8

    .line 62
    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v8, 0x3

    const/4 v9, 0x3

    aget v9, v6, v9

    aput v9, v7, v8

    .line 64
    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v8, 0x0

    aget v2, v7, v8

    .line 65
    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v8, 0x1

    aget v3, v7, v8

    .line 66
    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v8, 0x2

    aget v4, v7, v8

    .line 67
    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v8, 0x3

    aget v5, v7, v8

    .line 69
    const/high16 v7, 0x40000000    # 2.0f

    mul-float v8, v2, v3

    mul-float v9, v4, v5

    add-float/2addr v8, v9

    mul-float/2addr v7, v8

    float-to-double v8, v7

    const/high16 v7, 0x3f800000    # 1.0f

    const/high16 v10, 0x40000000    # 2.0f

    mul-float v11, v3, v3

    mul-float v12, v4, v4

    add-float/2addr v11, v12

    mul-float/2addr v10, v11

    sub-float/2addr v7, v10

    float-to-double v10, v7

    invoke-static {v8, v9, v10, v11}, Ljava/lang/Math;->atan2(DD)D

    move-result-wide v8

    invoke-static {v8, v9}, Ljava/lang/Math;->toDegrees(D)D

    move-result-wide v8

    double-to-float v7, v8

    iput v7, p0, Lcom/adobe/air/DeviceRotation;->m_pitch:F

    .line 70
    const/high16 v7, 0x40000000    # 2.0f

    mul-float v8, v2, v4

    mul-float v9, v5, v3

    sub-float/2addr v8, v9

    mul-float/2addr v7, v8

    float-to-double v8, v7

    invoke-static {v8, v9}, Ljava/lang/Math;->asin(D)D

    move-result-wide v8

    invoke-static {v8, v9}, Ljava/lang/Math;->toDegrees(D)D

    move-result-wide v8

    double-to-float v7, v8

    iput v7, p0, Lcom/adobe/air/DeviceRotation;->m_roll:F

    .line 71
    const/high16 v7, 0x40000000    # 2.0f

    mul-float v8, v2, v5

    mul-float v9, v3, v4

    add-float/2addr v8, v9

    mul-float/2addr v7, v8

    float-to-double v8, v7

    const/high16 v7, 0x3f800000    # 1.0f

    const/high16 v10, 0x40000000    # 2.0f

    mul-float v11, v4, v4

    mul-float v12, v5, v5

    add-float/2addr v11, v12

    mul-float/2addr v10, v11

    sub-float/2addr v7, v10

    float-to-double v10, v7

    invoke-static {v8, v9, v10, v11}, Ljava/lang/Math;->atan2(DD)D

    move-result-wide v8

    invoke-static {v8, v9}, Ljava/lang/Math;->toDegrees(D)D

    move-result-wide v8

    double-to-float v7, v8

    const/high16 v8, 0x43340000    # 180.0f

    add-float/2addr v7, v8

    iput v7, p0, Lcom/adobe/air/DeviceRotation;->m_yaw:F

    .line 73
    iget v7, p0, Lcom/adobe/air/DeviceRotation;->m_pitch:F

    iget v8, p0, Lcom/adobe/air/DeviceRotation;->m_roll:F

    iget v9, p0, Lcom/adobe/air/DeviceRotation;->m_yaw:F

    invoke-direct {p0, v7, v8, v9}, Lcom/adobe/air/DeviceRotation;->recalculateQuaternion(FFF)[F

    move-result-object v0

    .line 75
    .local v0, "modifiedQuat":[F
    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v8, 0x0

    const/4 v9, 0x0

    aget v9, v0, v9

    aput v9, v7, v8

    .line 76
    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v8, 0x1

    const/4 v9, 0x1

    aget v9, v0, v9

    aput v9, v7, v8

    .line 77
    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v8, 0x2

    const/4 v9, 0x2

    aget v9, v0, v9

    aput v9, v7, v8

    .line 78
    iget-object v7, p0, Lcom/adobe/air/DeviceRotation;->m_quaternion_data:[F

    const/4 v8, 0x3

    const/4 v9, 0x3

    aget v9, v0, v9

    aput v9, v7, v8

    goto/16 :goto_0

    .line 39
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method public removeListener()V
    .locals 1

    .prologue
    .line 122
    invoke-direct {p0}, Lcom/adobe/air/DeviceRotation;->hasRequiredSensors()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 124
    iget-object v0, p0, Lcom/adobe/air/DeviceRotation;->mSensorManager:Landroid/hardware/SensorManager;

    invoke-virtual {v0, p0}, Landroid/hardware/SensorManager;->unregisterListener(Landroid/hardware/SensorEventListener;)V

    .line 126
    :cond_0
    return-void
.end method

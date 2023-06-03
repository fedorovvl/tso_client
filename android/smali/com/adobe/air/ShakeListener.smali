.class public Lcom/adobe/air/ShakeListener;
.super Ljava/lang/Object;
.source "ShakeListener.java"

# interfaces
.implements Landroid/hardware/SensorEventListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adobe/air/ShakeListener$Listener;
    }
.end annotation


# static fields
.field private static final FORCE_THRESHOLD:I = 0x4b0

.field private static final SHAKE_COUNT:I = 0x2

.field private static final SHAKE_DURATION:I = 0x3e8

.field private static final SHAKE_TIMEOUT:I = 0x1f4

.field private static final TIME_THRESHOLD:I = 0x64


# instance fields
.field private mAccelerometer:Landroid/hardware/Sensor;

.field private mContext:Landroid/content/Context;

.field private mLastForce:J

.field private mLastShake:J

.field private mLastTime:J

.field private mLastX:F

.field private mLastY:F

.field private mLastZ:F

.field private mListener:Lcom/adobe/air/ShakeListener$Listener;

.field private mSensorMgr:Landroid/hardware/SensorManager;

.field private mShakeCount:I


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    const-wide/16 v2, 0x0

    const/high16 v1, -0x40800000    # -1.0f

    const/4 v0, 0x0

    .line 50
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    iput-object v0, p0, Lcom/adobe/air/ShakeListener;->mAccelerometer:Landroid/hardware/Sensor;

    .line 37
    iput-object v0, p0, Lcom/adobe/air/ShakeListener;->mSensorMgr:Landroid/hardware/SensorManager;

    .line 38
    iput v1, p0, Lcom/adobe/air/ShakeListener;->mLastX:F

    iput v1, p0, Lcom/adobe/air/ShakeListener;->mLastY:F

    iput v1, p0, Lcom/adobe/air/ShakeListener;->mLastZ:F

    .line 39
    iput-wide v2, p0, Lcom/adobe/air/ShakeListener;->mLastTime:J

    .line 40
    iput-object v0, p0, Lcom/adobe/air/ShakeListener;->mListener:Lcom/adobe/air/ShakeListener$Listener;

    .line 41
    iput-object v0, p0, Lcom/adobe/air/ShakeListener;->mContext:Landroid/content/Context;

    .line 42
    const/4 v0, 0x0

    iput v0, p0, Lcom/adobe/air/ShakeListener;->mShakeCount:I

    .line 43
    iput-wide v2, p0, Lcom/adobe/air/ShakeListener;->mLastShake:J

    .line 44
    iput-wide v2, p0, Lcom/adobe/air/ShakeListener;->mLastForce:J

    .line 52
    if-nez p1, :cond_0

    new-instance v0, Ljava/lang/Exception;

    const-string v1, "Invalid context"

    invoke-direct {v0, v1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw v0

    .line 54
    :cond_0
    iput-object p1, p0, Lcom/adobe/air/ShakeListener;->mContext:Landroid/content/Context;

    .line 55
    invoke-virtual {p0}, Lcom/adobe/air/ShakeListener;->resume()V

    .line 56
    return-void
.end method


# virtual methods
.method public onAccuracyChanged(Landroid/hardware/Sensor;I)V
    .locals 0
    .param p1, "sensor"    # Landroid/hardware/Sensor;
    .param p2, "accuracy"    # I

    .prologue
    .line 109
    return-void
.end method

.method public onSensorChanged(Landroid/hardware/SensorEvent;)V
    .locals 13
    .param p1, "event"    # Landroid/hardware/SensorEvent;

    .prologue
    const/4 v12, 0x1

    const/4 v11, 0x2

    const/4 v10, 0x0

    .line 114
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    .line 118
    .local v4, "now":J
    iget-wide v6, p0, Lcom/adobe/air/ShakeListener;->mLastForce:J

    sub-long v6, v4, v6

    const-wide/16 v8, 0x1f4

    cmp-long v3, v6, v8

    if-lez v3, :cond_0

    .line 119
    iput v10, p0, Lcom/adobe/air/ShakeListener;->mShakeCount:I

    .line 124
    :cond_0
    iget-wide v6, p0, Lcom/adobe/air/ShakeListener;->mLastTime:J

    sub-long v6, v4, v6

    const-wide/16 v8, 0x64

    cmp-long v3, v6, v8

    if-lez v3, :cond_3

    .line 129
    iget-wide v6, p0, Lcom/adobe/air/ShakeListener;->mLastTime:J

    sub-long v0, v4, v6

    .line 133
    .local v0, "diff":J
    iget-object v3, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v3, v3, v10

    iget v6, p0, Lcom/adobe/air/ShakeListener;->mLastX:F

    sub-float/2addr v3, v6

    iget-object v6, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v6, v6, v10

    iget v7, p0, Lcom/adobe/air/ShakeListener;->mLastX:F

    sub-float/2addr v6, v7

    mul-float v2, v3, v6

    .line 134
    .local v2, "force":F
    iget-object v3, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v3, v3, v12

    iget v6, p0, Lcom/adobe/air/ShakeListener;->mLastY:F

    sub-float/2addr v3, v6

    iget-object v6, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v6, v6, v12

    iget v7, p0, Lcom/adobe/air/ShakeListener;->mLastY:F

    sub-float/2addr v6, v7

    mul-float/2addr v3, v6

    add-float/2addr v2, v3

    .line 135
    iget-object v3, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v3, v3, v11

    iget v6, p0, Lcom/adobe/air/ShakeListener;->mLastZ:F

    sub-float/2addr v3, v6

    iget-object v6, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v6, v6, v11

    iget v7, p0, Lcom/adobe/air/ShakeListener;->mLastZ:F

    sub-float/2addr v6, v7

    mul-float/2addr v3, v6

    add-float/2addr v2, v3

    .line 137
    float-to-double v6, v2

    invoke-static {v6, v7}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v6

    long-to-double v8, v0

    div-double/2addr v6, v8

    const-wide v8, 0x40c3880000000000L    # 10000.0

    mul-double/2addr v6, v8

    double-to-float v2, v6

    .line 140
    const/high16 v3, 0x44960000    # 1200.0f

    cmpl-float v3, v2, v3

    if-lez v3, :cond_2

    .line 144
    iget v3, p0, Lcom/adobe/air/ShakeListener;->mShakeCount:I

    add-int/lit8 v3, v3, 0x1

    iput v3, p0, Lcom/adobe/air/ShakeListener;->mShakeCount:I

    if-lt v3, v11, :cond_1

    iget-wide v6, p0, Lcom/adobe/air/ShakeListener;->mLastShake:J

    sub-long v6, v4, v6

    const-wide/16 v8, 0x3e8

    cmp-long v3, v6, v8

    if-lez v3, :cond_1

    .line 146
    iput-wide v4, p0, Lcom/adobe/air/ShakeListener;->mLastShake:J

    .line 147
    iput v10, p0, Lcom/adobe/air/ShakeListener;->mShakeCount:I

    .line 149
    iget-object v3, p0, Lcom/adobe/air/ShakeListener;->mListener:Lcom/adobe/air/ShakeListener$Listener;

    if-eqz v3, :cond_1

    .line 150
    iget-object v3, p0, Lcom/adobe/air/ShakeListener;->mListener:Lcom/adobe/air/ShakeListener$Listener;

    invoke-interface {v3}, Lcom/adobe/air/ShakeListener$Listener;->onShake()V

    .line 153
    :cond_1
    iput-wide v4, p0, Lcom/adobe/air/ShakeListener;->mLastForce:J

    .line 157
    :cond_2
    iput-wide v4, p0, Lcom/adobe/air/ShakeListener;->mLastTime:J

    .line 158
    iget-object v3, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v3, v3, v10

    iput v3, p0, Lcom/adobe/air/ShakeListener;->mLastX:F

    .line 159
    iget-object v3, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v3, v3, v12

    iput v3, p0, Lcom/adobe/air/ShakeListener;->mLastY:F

    .line 160
    iget-object v3, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v3, v3, v11

    iput v3, p0, Lcom/adobe/air/ShakeListener;->mLastZ:F

    .line 162
    .end local v0    # "diff":J
    .end local v2    # "force":F
    :cond_3
    return-void
.end method

.method public pause()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 99
    iget-object v0, p0, Lcom/adobe/air/ShakeListener;->mSensorMgr:Landroid/hardware/SensorManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/adobe/air/ShakeListener;->mAccelerometer:Landroid/hardware/Sensor;

    if-eqz v0, :cond_0

    .line 101
    iget-object v0, p0, Lcom/adobe/air/ShakeListener;->mSensorMgr:Landroid/hardware/SensorManager;

    iget-object v1, p0, Lcom/adobe/air/ShakeListener;->mAccelerometer:Landroid/hardware/Sensor;

    invoke-virtual {v0, p0, v1}, Landroid/hardware/SensorManager;->unregisterListener(Landroid/hardware/SensorEventListener;Landroid/hardware/Sensor;)V

    .line 102
    iput-object v2, p0, Lcom/adobe/air/ShakeListener;->mSensorMgr:Landroid/hardware/SensorManager;

    .line 103
    iput-object v2, p0, Lcom/adobe/air/ShakeListener;->mAccelerometer:Landroid/hardware/Sensor;

    .line 105
    :cond_0
    return-void
.end method

.method public registerListener(Lcom/adobe/air/ShakeListener$Listener;)V
    .locals 0
    .param p1, "listener"    # Lcom/adobe/air/ShakeListener$Listener;

    .prologue
    .line 60
    iput-object p1, p0, Lcom/adobe/air/ShakeListener;->mListener:Lcom/adobe/air/ShakeListener$Listener;

    .line 61
    return-void
.end method

.method public resume()V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    const/4 v4, 0x0

    .line 70
    iget-object v1, p0, Lcom/adobe/air/ShakeListener;->mSensorMgr:Landroid/hardware/SensorManager;

    if-eqz v1, :cond_1

    .line 95
    :cond_0
    return-void

    .line 73
    :cond_1
    iput-object v4, p0, Lcom/adobe/air/ShakeListener;->mAccelerometer:Landroid/hardware/Sensor;

    .line 75
    iget-object v1, p0, Lcom/adobe/air/ShakeListener;->mContext:Landroid/content/Context;

    const-string v2, "sensor"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/hardware/SensorManager;

    iput-object v1, p0, Lcom/adobe/air/ShakeListener;->mSensorMgr:Landroid/hardware/SensorManager;

    .line 76
    iget-object v1, p0, Lcom/adobe/air/ShakeListener;->mSensorMgr:Landroid/hardware/SensorManager;

    if-nez v1, :cond_2

    .line 77
    new-instance v1, Ljava/lang/UnsupportedOperationException;

    const-string v2, "Sensors not supported"

    invoke-direct {v1, v2}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 79
    :cond_2
    iget-object v1, p0, Lcom/adobe/air/ShakeListener;->mSensorMgr:Landroid/hardware/SensorManager;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/hardware/SensorManager;->getDefaultSensor(I)Landroid/hardware/Sensor;

    move-result-object v1

    iput-object v1, p0, Lcom/adobe/air/ShakeListener;->mAccelerometer:Landroid/hardware/Sensor;

    .line 80
    iget-object v1, p0, Lcom/adobe/air/ShakeListener;->mAccelerometer:Landroid/hardware/Sensor;

    if-nez v1, :cond_3

    .line 82
    iput-object v4, p0, Lcom/adobe/air/ShakeListener;->mSensorMgr:Landroid/hardware/SensorManager;

    .line 83
    new-instance v1, Ljava/lang/UnsupportedOperationException;

    const-string v2, "Accelerometer is not supported"

    invoke-direct {v1, v2}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 86
    :cond_3
    iget-object v1, p0, Lcom/adobe/air/ShakeListener;->mSensorMgr:Landroid/hardware/SensorManager;

    iget-object v2, p0, Lcom/adobe/air/ShakeListener;->mAccelerometer:Landroid/hardware/Sensor;

    const/4 v3, 0x2

    invoke-virtual {v1, p0, v2, v3}, Landroid/hardware/SensorManager;->registerListener(Landroid/hardware/SensorEventListener;Landroid/hardware/Sensor;I)Z

    move-result v0

    .line 88
    .local v0, "supported":Z
    if-nez v0, :cond_0

    .line 90
    iput-object v4, p0, Lcom/adobe/air/ShakeListener;->mSensorMgr:Landroid/hardware/SensorManager;

    .line 91
    iput-object v4, p0, Lcom/adobe/air/ShakeListener;->mAccelerometer:Landroid/hardware/Sensor;

    .line 93
    new-instance v1, Ljava/lang/UnsupportedOperationException;

    const-string v2, "Accelerometer is not supported"

    invoke-direct {v1, v2}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method public unregisterListener()V
    .locals 1

    .prologue
    .line 65
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/ShakeListener;->mListener:Lcom/adobe/air/ShakeListener$Listener;

    .line 66
    return-void
.end method

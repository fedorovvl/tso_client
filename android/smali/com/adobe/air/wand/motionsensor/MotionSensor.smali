.class public abstract Lcom/adobe/air/wand/motionsensor/MotionSensor;
.super Ljava/lang/Object;
.source "MotionSensor.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adobe/air/wand/motionsensor/MotionSensor$Listener;
    }
.end annotation


# static fields
.field protected static final LOG_TAG:Ljava/lang/String; = "MotionSensor"


# instance fields
.field protected mActivity:Landroid/app/Activity;

.field protected mRegistered:Z

.field protected mSensor:Landroid/hardware/Sensor;

.field protected mSensorDelay:I

.field protected mSensorEventListener:Landroid/hardware/SensorEventListener;

.field protected mSensorManager:Landroid/hardware/SensorManager;


# direct methods
.method public constructor <init>(Landroid/app/Activity;I)V
    .locals 2
    .param p1, "activity"    # Landroid/app/Activity;
    .param p2, "sensorType"    # I

    .prologue
    const/4 v1, 0x0

    .line 46
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 39
    iput-object v1, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mSensorManager:Landroid/hardware/SensorManager;

    .line 40
    iput-object v1, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mSensor:Landroid/hardware/Sensor;

    .line 41
    iput-object v1, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mSensorEventListener:Landroid/hardware/SensorEventListener;

    .line 42
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mRegistered:Z

    .line 43
    const/4 v0, 0x1

    iput v0, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mSensorDelay:I

    .line 44
    iput-object v1, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mActivity:Landroid/app/Activity;

    .line 48
    iput-object p1, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mActivity:Landroid/app/Activity;

    .line 49
    iget-object v0, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mActivity:Landroid/app/Activity;

    const-string v1, "sensor"

    invoke-virtual {v0, v1}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/SensorManager;

    iput-object v0, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mSensorManager:Landroid/hardware/SensorManager;

    .line 50
    iget-object v0, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mSensorManager:Landroid/hardware/SensorManager;

    invoke-virtual {v0, p2}, Landroid/hardware/SensorManager;->getDefaultSensor(I)Landroid/hardware/Sensor;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mSensor:Landroid/hardware/Sensor;

    .line 52
    iget-object v0, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mSensor:Landroid/hardware/Sensor;

    if-eqz v0, :cond_0

    .line 60
    :cond_0
    return-void
.end method

.method static synthetic access$000(Lcom/adobe/air/wand/motionsensor/MotionSensor;[F)[F
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/wand/motionsensor/MotionSensor;
    .param p1, "x1"    # [F

    .prologue
    .line 35
    invoke-direct {p0, p1}, Lcom/adobe/air/wand/motionsensor/MotionSensor;->getScreenOrientedValues([F)[F

    move-result-object v0

    return-object v0
.end method

.method private getScreenOrientedValues([F)[F
    .locals 5
    .param p1, "values"    # [F

    .prologue
    const/4 v4, 0x0

    const/4 v3, 0x1

    .line 71
    invoke-virtual {p1}, [F->clone()Ljava/lang/Object;

    move-result-object p1

    .end local p1    # "values":[F
    check-cast p1, [F

    .line 73
    .restart local p1    # "values":[F
    iget-object v2, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mActivity:Landroid/app/Activity;

    invoke-virtual {v2}, Landroid/app/Activity;->getWindowManager()Landroid/view/WindowManager;

    move-result-object v2

    invoke-interface {v2}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/Display;->getRotation()I

    move-result v1

    .line 76
    .local v1, "rotation":I
    if-nez v1, :cond_1

    .line 97
    :cond_0
    :goto_0
    return-object p1

    .line 78
    :cond_1
    const/4 v2, 0x2

    if-ne v1, v2, :cond_2

    .line 79
    aget v2, p1, v4

    neg-float v2, v2

    aput v2, p1, v4

    .line 80
    aget v2, p1, v3

    neg-float v2, v2

    aput v2, p1, v3

    goto :goto_0

    .line 84
    :cond_2
    if-ne v1, v3, :cond_3

    .line 85
    aget v0, p1, v4

    .line 86
    .local v0, "newY":F
    aget v2, p1, v3

    neg-float v2, v2

    aput v2, p1, v4

    .line 87
    aput v0, p1, v3

    goto :goto_0

    .line 91
    .end local v0    # "newY":F
    :cond_3
    const/4 v2, 0x3

    if-ne v1, v2, :cond_0

    .line 92
    aget v2, p1, v4

    neg-float v0, v2

    .line 93
    .restart local v0    # "newY":F
    aget v2, p1, v3

    aput v2, p1, v4

    .line 94
    aput v0, p1, v3

    goto :goto_0
.end method


# virtual methods
.method public active()Z
    .locals 1

    .prologue
    .line 156
    iget-boolean v0, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mRegistered:Z

    return v0
.end method

.method public available()Z
    .locals 1

    .prologue
    .line 152
    iget-object v0, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mSensor:Landroid/hardware/Sensor;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public dispose()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 161
    invoke-virtual {p0}, Lcom/adobe/air/wand/motionsensor/MotionSensor;->stop()V

    .line 164
    invoke-virtual {p0, v0}, Lcom/adobe/air/wand/motionsensor/MotionSensor;->setListener(Lcom/adobe/air/wand/motionsensor/MotionSensor$Listener;)V

    .line 166
    iput-object v0, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mSensor:Landroid/hardware/Sensor;

    .line 169
    iput-object v0, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mSensorManager:Landroid/hardware/SensorManager;

    .line 172
    iput-object v0, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mActivity:Landroid/app/Activity;

    .line 173
    return-void
.end method

.method public setListener(Lcom/adobe/air/wand/motionsensor/MotionSensor$Listener;)V
    .locals 2
    .param p1, "listener"    # Lcom/adobe/air/wand/motionsensor/MotionSensor$Listener;

    .prologue
    .line 102
    iget-boolean v0, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mRegistered:Z

    .line 104
    .local v0, "wasRegistered":Z
    invoke-virtual {p0}, Lcom/adobe/air/wand/motionsensor/MotionSensor;->stop()V

    .line 106
    if-nez p1, :cond_1

    const/4 v1, 0x0

    :goto_0
    iput-object v1, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mSensorEventListener:Landroid/hardware/SensorEventListener;

    .line 120
    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lcom/adobe/air/wand/motionsensor/MotionSensor;->start()V

    .line 121
    :cond_0
    return-void

    .line 106
    :cond_1
    new-instance v1, Lcom/adobe/air/wand/motionsensor/MotionSensor$1;

    invoke-direct {v1, p0, p1}, Lcom/adobe/air/wand/motionsensor/MotionSensor$1;-><init>(Lcom/adobe/air/wand/motionsensor/MotionSensor;Lcom/adobe/air/wand/motionsensor/MotionSensor$Listener;)V

    goto :goto_0
.end method

.method public start()V
    .locals 4

    .prologue
    .line 131
    iget-boolean v0, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mRegistered:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mSensor:Landroid/hardware/Sensor;

    if-eqz v0, :cond_0

    .line 132
    iget-object v0, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mSensorManager:Landroid/hardware/SensorManager;

    iget-object v1, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mSensorEventListener:Landroid/hardware/SensorEventListener;

    iget-object v2, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mSensor:Landroid/hardware/Sensor;

    iget v3, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mSensorDelay:I

    invoke-virtual {v0, v1, v2, v3}, Landroid/hardware/SensorManager;->registerListener(Landroid/hardware/SensorEventListener;Landroid/hardware/Sensor;I)Z

    move-result v0

    iput-boolean v0, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mRegistered:Z

    .line 135
    iget-boolean v0, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mRegistered:Z

    if-eqz v0, :cond_0

    .line 141
    :cond_0
    return-void
.end method

.method public start(I)V
    .locals 1
    .param p1, "sensorDelay"    # I

    .prologue
    .line 124
    iget-boolean v0, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mRegistered:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mSensor:Landroid/hardware/Sensor;

    if-eqz v0, :cond_0

    .line 125
    mul-int/lit16 v0, p1, 0x3e8

    iput v0, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mSensorDelay:I

    .line 126
    invoke-virtual {p0}, Lcom/adobe/air/wand/motionsensor/MotionSensor;->start()V

    .line 128
    :cond_0
    return-void
.end method

.method public stop()V
    .locals 3

    .prologue
    .line 144
    iget-boolean v0, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mRegistered:Z

    if-eqz v0, :cond_0

    .line 145
    iget-object v0, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mSensorManager:Landroid/hardware/SensorManager;

    iget-object v1, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mSensorEventListener:Landroid/hardware/SensorEventListener;

    iget-object v2, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mSensor:Landroid/hardware/Sensor;

    invoke-virtual {v0, v1, v2}, Landroid/hardware/SensorManager;->unregisterListener(Landroid/hardware/SensorEventListener;Landroid/hardware/Sensor;)V

    .line 147
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor;->mRegistered:Z

    .line 149
    :cond_0
    return-void
.end method

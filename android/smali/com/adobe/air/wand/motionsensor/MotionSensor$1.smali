.class Lcom/adobe/air/wand/motionsensor/MotionSensor$1;
.super Ljava/lang/Object;
.source "MotionSensor.java"

# interfaces
.implements Landroid/hardware/SensorEventListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/wand/motionsensor/MotionSensor;->setListener(Lcom/adobe/air/wand/motionsensor/MotionSensor$Listener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/wand/motionsensor/MotionSensor;

.field final synthetic val$listener:Lcom/adobe/air/wand/motionsensor/MotionSensor$Listener;


# direct methods
.method constructor <init>(Lcom/adobe/air/wand/motionsensor/MotionSensor;Lcom/adobe/air/wand/motionsensor/MotionSensor$Listener;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/wand/motionsensor/MotionSensor;

    .prologue
    .line 106
    iput-object p1, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor$1;->this$0:Lcom/adobe/air/wand/motionsensor/MotionSensor;

    iput-object p2, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor$1;->val$listener:Lcom/adobe/air/wand/motionsensor/MotionSensor$Listener;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAccuracyChanged(Landroid/hardware/Sensor;I)V
    .locals 0
    .param p1, "sensor"    # Landroid/hardware/Sensor;
    .param p2, "newAccuracy"    # I

    .prologue
    .line 117
    return-void
.end method

.method public onSensorChanged(Landroid/hardware/SensorEvent;)V
    .locals 4
    .param p1, "sensorevent"    # Landroid/hardware/SensorEvent;

    .prologue
    .line 110
    iget-object v0, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor$1;->val$listener:Lcom/adobe/air/wand/motionsensor/MotionSensor$Listener;

    iget-object v1, p0, Lcom/adobe/air/wand/motionsensor/MotionSensor$1;->this$0:Lcom/adobe/air/wand/motionsensor/MotionSensor;

    iget-object v2, p1, Landroid/hardware/SensorEvent;->values:[F

    invoke-static {v1, v2}, Lcom/adobe/air/wand/motionsensor/MotionSensor;->access$000(Lcom/adobe/air/wand/motionsensor/MotionSensor;[F)[F

    move-result-object v1

    iget-wide v2, p1, Landroid/hardware/SensorEvent;->timestamp:J

    invoke-interface {v0, v1, v2, v3}, Lcom/adobe/air/wand/motionsensor/MotionSensor$Listener;->onSensorChanged([FJ)V

    .line 111
    return-void
.end method

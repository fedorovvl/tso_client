.class public Lcom/adobe/air/wand/motionsensor/Magnetometer;
.super Lcom/adobe/air/wand/motionsensor/MotionSensor;
.source "Magnetometer.java"


# direct methods
.method public constructor <init>(Landroid/app/Activity;)V
    .locals 1
    .param p1, "activity"    # Landroid/app/Activity;

    .prologue
    .line 28
    const/4 v0, 0x2

    invoke-direct {p0, p1, v0}, Lcom/adobe/air/wand/motionsensor/MotionSensor;-><init>(Landroid/app/Activity;I)V

    .line 29
    return-void
.end method

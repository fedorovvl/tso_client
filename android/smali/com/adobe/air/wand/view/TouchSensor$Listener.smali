.class public interface abstract Lcom/adobe/air/wand/view/TouchSensor$Listener;
.super Ljava/lang/Object;
.source "TouchSensor.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/wand/view/TouchSensor;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x609
    name = "Listener"
.end annotation


# virtual methods
.method public abstract onGestureEvent(Lcom/adobe/air/wand/view/GestureEventData;)V
.end method

.method public abstract onTouchEvent(Lcom/adobe/air/TouchEventData;)V
.end method

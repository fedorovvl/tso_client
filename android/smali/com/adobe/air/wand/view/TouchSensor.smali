.class public Lcom/adobe/air/wand/view/TouchSensor;
.super Ljava/lang/Object;
.source "TouchSensor.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adobe/air/wand/view/TouchSensor$Listener;
    }
.end annotation


# static fields
.field private static final LOG_TAG:Ljava/lang/String; = "TouchSensor"


# instance fields
.field private mGestureEventListening:Z

.field private mListener:Lcom/adobe/air/wand/view/TouchSensor$Listener;

.field private mTouchEventListening:Z


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 30
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/wand/view/TouchSensor;->mListener:Lcom/adobe/air/wand/view/TouchSensor$Listener;

    .line 31
    iput-boolean v1, p0, Lcom/adobe/air/wand/view/TouchSensor;->mTouchEventListening:Z

    .line 32
    iput-boolean v1, p0, Lcom/adobe/air/wand/view/TouchSensor;->mGestureEventListening:Z

    return-void
.end method


# virtual methods
.method public TouchListener()V
    .locals 0

    .prologue
    .line 34
    return-void
.end method

.method public activeGestureListening()Z
    .locals 1

    .prologue
    .line 81
    iget-boolean v0, p0, Lcom/adobe/air/wand/view/TouchSensor;->mGestureEventListening:Z

    return v0
.end method

.method public activeTouchListening()Z
    .locals 1

    .prologue
    .line 76
    iget-boolean v0, p0, Lcom/adobe/air/wand/view/TouchSensor;->mTouchEventListening:Z

    return v0
.end method

.method dispatchEvent(Lcom/adobe/air/TouchEventData;)V
    .locals 1
    .param p1, "touchEvent"    # Lcom/adobe/air/TouchEventData;

    .prologue
    .line 45
    iget-boolean v0, p0, Lcom/adobe/air/wand/view/TouchSensor;->mTouchEventListening:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/adobe/air/wand/view/TouchSensor;->mListener:Lcom/adobe/air/wand/view/TouchSensor$Listener;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/adobe/air/wand/view/TouchSensor;->mListener:Lcom/adobe/air/wand/view/TouchSensor$Listener;

    invoke-interface {v0, p1}, Lcom/adobe/air/wand/view/TouchSensor$Listener;->onTouchEvent(Lcom/adobe/air/TouchEventData;)V

    .line 46
    :cond_0
    return-void
.end method

.method dispatchEvent(Lcom/adobe/air/wand/view/GestureEventData;)V
    .locals 1
    .param p1, "gestureEvent"    # Lcom/adobe/air/wand/view/GestureEventData;

    .prologue
    .line 51
    iget-boolean v0, p0, Lcom/adobe/air/wand/view/TouchSensor;->mGestureEventListening:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/adobe/air/wand/view/TouchSensor;->mListener:Lcom/adobe/air/wand/view/TouchSensor$Listener;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/adobe/air/wand/view/TouchSensor;->mListener:Lcom/adobe/air/wand/view/TouchSensor$Listener;

    invoke-interface {v0, p1}, Lcom/adobe/air/wand/view/TouchSensor$Listener;->onGestureEvent(Lcom/adobe/air/wand/view/GestureEventData;)V

    .line 52
    :cond_0
    return-void
.end method

.method public setListener(Lcom/adobe/air/wand/view/TouchSensor$Listener;)V
    .locals 2
    .param p1, "listener"    # Lcom/adobe/air/wand/view/TouchSensor$Listener;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 38
    if-nez p1, :cond_0

    new-instance v0, Ljava/lang/Exception;

    const-string v1, "Invalid Listener"

    invoke-direct {v0, v1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw v0

    .line 39
    :cond_0
    iput-object p1, p0, Lcom/adobe/air/wand/view/TouchSensor;->mListener:Lcom/adobe/air/wand/view/TouchSensor$Listener;

    .line 40
    return-void
.end method

.method public startGestureEventListening()V
    .locals 1

    .prologue
    .line 66
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/adobe/air/wand/view/TouchSensor;->mGestureEventListening:Z

    .line 67
    return-void
.end method

.method public startTouchEventListening()V
    .locals 1

    .prologue
    .line 56
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/adobe/air/wand/view/TouchSensor;->mTouchEventListening:Z

    .line 57
    return-void
.end method

.method public stopGestureEventListening()V
    .locals 1

    .prologue
    .line 71
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/wand/view/TouchSensor;->mGestureEventListening:Z

    .line 72
    return-void
.end method

.method public stopTouchEventListening()V
    .locals 1

    .prologue
    .line 61
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/wand/view/TouchSensor;->mTouchEventListening:Z

    .line 62
    return-void
.end method

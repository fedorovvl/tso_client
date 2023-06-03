.class public Lcom/adobe/air/customHandler;
.super Landroid/os/Handler;
.source "customHandler.java"


# static fields
.field public static final KEY_MSG_ID:I = 0x461

.field public static final TIME_OUT_MSG_ID:I = 0x45f

.field public static final TOUCH_MSG_ID:I = 0x460


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 7
    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public native callTimeoutFunction(II)V
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 13
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 20
    iget v0, p1, Landroid/os/Message;->what:I

    const/16 v1, 0x45f

    if-ne v0, v1, :cond_1

    .line 22
    iget v0, p1, Landroid/os/Message;->arg1:I

    iget v1, p1, Landroid/os/Message;->arg2:I

    invoke-virtual {p0, v0, v1}, Lcom/adobe/air/customHandler;->callTimeoutFunction(II)V

    .line 35
    :cond_0
    :goto_0
    return-void

    .line 24
    :cond_1
    iget v0, p1, Landroid/os/Message;->what:I

    const/16 v1, 0x460

    if-ne v0, v1, :cond_2

    .line 26
    iget-object v12, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v12, Lcom/adobe/air/TouchEventData;

    .line 27
    .local v12, "touchObj":Lcom/adobe/air/TouchEventData;
    iget v1, v12, Lcom/adobe/air/TouchEventData;->mTouchEventType:I

    iget v2, v12, Lcom/adobe/air/TouchEventData;->mXCoord:F

    iget v3, v12, Lcom/adobe/air/TouchEventData;->mYCoord:F

    iget v4, v12, Lcom/adobe/air/TouchEventData;->mPressure:F

    iget v5, v12, Lcom/adobe/air/TouchEventData;->mPointerID:I

    iget v6, v12, Lcom/adobe/air/TouchEventData;->mContactX:F

    iget v7, v12, Lcom/adobe/air/TouchEventData;->mContactY:F

    iget-boolean v8, v12, Lcom/adobe/air/TouchEventData;->mIsPrimaryPoint:Z

    iget-object v9, v12, Lcom/adobe/air/TouchEventData;->mHistory:[F

    iget v10, v12, Lcom/adobe/air/TouchEventData;->mMetaState:I

    move-object v0, p0

    invoke-virtual/range {v0 .. v10}, Lcom/adobe/air/customHandler;->nativeOnTouchCallback(IFFFIFFZ[FI)Z

    goto :goto_0

    .line 30
    .end local v12    # "touchObj":Lcom/adobe/air/TouchEventData;
    :cond_2
    iget v0, p1, Landroid/os/Message;->what:I

    const/16 v1, 0x461

    if-ne v0, v1, :cond_0

    .line 32
    iget-object v11, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v11, Lcom/adobe/air/KeyEventData;

    .line 33
    .local v11, "keyObj":Lcom/adobe/air/KeyEventData;
    iget v1, v11, Lcom/adobe/air/KeyEventData;->mKeyAction:I

    iget v2, v11, Lcom/adobe/air/KeyEventData;->mKeyCode:I

    iget v3, v11, Lcom/adobe/air/KeyEventData;->mUnicode:I

    iget-boolean v4, v11, Lcom/adobe/air/KeyEventData;->mAlt:Z

    iget-boolean v5, v11, Lcom/adobe/air/KeyEventData;->mShift:Z

    iget-boolean v6, v11, Lcom/adobe/air/KeyEventData;->mSym:Z

    move-object v0, p0

    invoke-virtual/range {v0 .. v6}, Lcom/adobe/air/customHandler;->nativeOnKeyCallback(IIIZZZ)Z

    goto :goto_0
.end method

.method public native nativeOnKeyCallback(IIIZZZ)Z
.end method

.method public native nativeOnTouchCallback(IFFFIFFZ[FI)Z
.end method

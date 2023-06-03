.class Lcom/adobe/air/AndroidInputDevice;
.super Ljava/lang/Object;
.source "AndroidInputManager.java"


# instance fields
.field private mDevice:Landroid/view/InputDevice;

.field private mInputControls:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/adobe/air/AndroidInputControl;",
            ">;"
        }
    .end annotation
.end field

.field private mNumControls:I


# direct methods
.method public constructor <init>(Landroid/view/InputDevice;)V
    .locals 9
    .param p1, "device"    # Landroid/view/InputDevice;

    .prologue
    const/4 v4, 0x0

    .line 266
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 261
    iput-object v4, p0, Lcom/adobe/air/AndroidInputDevice;->mDevice:Landroid/view/InputDevice;

    .line 262
    iput-object v4, p0, Lcom/adobe/air/AndroidInputDevice;->mInputControls:Ljava/util/List;

    .line 263
    const/4 v4, 0x0

    iput v4, p0, Lcom/adobe/air/AndroidInputDevice;->mNumControls:I

    .line 267
    iput-object p1, p0, Lcom/adobe/air/AndroidInputDevice;->mDevice:Landroid/view/InputDevice;

    .line 268
    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    iput-object v4, p0, Lcom/adobe/air/AndroidInputDevice;->mInputControls:Ljava/util/List;

    .line 270
    invoke-virtual {p1}, Landroid/view/InputDevice;->getMotionRanges()Ljava/util/List;

    move-result-object v3

    .line 271
    .local v3, "ranges":Ljava/util/List;, "Ljava/util/List<Landroid/view/InputDevice$MotionRange;>;"
    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :cond_0
    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_1

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/view/InputDevice$MotionRange;

    .line 273
    .local v2, "range":Landroid/view/InputDevice$MotionRange;
    invoke-virtual {v2}, Landroid/view/InputDevice$MotionRange;->getSource()I

    move-result v5

    and-int/lit8 v5, v5, 0x10

    if-eqz v5, :cond_0

    .line 277
    new-instance v1, Lcom/adobe/air/AndroidInputControl;

    sget-object v5, Lcom/adobe/air/ControlType;->AXIS:Lcom/adobe/air/ControlType;

    invoke-virtual {v2}, Landroid/view/InputDevice$MotionRange;->getAxis()I

    move-result v6

    invoke-virtual {v2}, Landroid/view/InputDevice$MotionRange;->getMin()F

    move-result v7

    invoke-virtual {v2}, Landroid/view/InputDevice$MotionRange;->getMax()F

    move-result v8

    invoke-direct {v1, v5, v6, v7, v8}, Lcom/adobe/air/AndroidInputControl;-><init>(Lcom/adobe/air/ControlType;IFF)V

    .line 278
    .local v1, "inputControl":Lcom/adobe/air/AndroidInputControl;
    iget-object v5, p0, Lcom/adobe/air/AndroidInputDevice;->mInputControls:Ljava/util/List;

    invoke-interface {v5, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 279
    iget v5, p0, Lcom/adobe/air/AndroidInputDevice;->mNumControls:I

    add-int/lit8 v5, v5, 0x1

    iput v5, p0, Lcom/adobe/air/AndroidInputDevice;->mNumControls:I

    goto :goto_0

    .line 283
    .end local v1    # "inputControl":Lcom/adobe/air/AndroidInputControl;
    .end local v2    # "range":Landroid/view/InputDevice$MotionRange;
    :cond_1
    const/4 v0, 0x0

    .local v0, "index":I
    :goto_1
    invoke-static {}, Landroid/view/KeyEvent;->getMaxKeyCode()I

    move-result v4

    if-ge v0, v4, :cond_3

    .line 285
    invoke-static {v0}, Landroid/view/KeyCharacterMap;->deviceHasKey(I)Z

    move-result v4

    if-eqz v4, :cond_2

    invoke-static {v0}, Lcom/adobe/air/AndroidInputDevice;->isGameKey(I)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 287
    new-instance v1, Lcom/adobe/air/AndroidInputControl;

    sget-object v4, Lcom/adobe/air/ControlType;->BUTTON:Lcom/adobe/air/ControlType;

    const/4 v5, 0x0

    const/high16 v6, 0x3f800000    # 1.0f

    invoke-direct {v1, v4, v0, v5, v6}, Lcom/adobe/air/AndroidInputControl;-><init>(Lcom/adobe/air/ControlType;IFF)V

    .line 290
    .restart local v1    # "inputControl":Lcom/adobe/air/AndroidInputControl;
    iget-object v4, p0, Lcom/adobe/air/AndroidInputDevice;->mInputControls:Ljava/util/List;

    invoke-interface {v4, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 291
    iget v4, p0, Lcom/adobe/air/AndroidInputDevice;->mNumControls:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/adobe/air/AndroidInputDevice;->mNumControls:I

    .line 283
    .end local v1    # "inputControl":Lcom/adobe/air/AndroidInputControl;
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 294
    :cond_3
    return-void
.end method

.method private static isGameKey(I)Z
    .locals 1
    .param p0, "keyCode"    # I

    .prologue
    .line 322
    packed-switch p0, :pswitch_data_0

    .line 331
    invoke-static {p0}, Landroid/view/KeyEvent;->isGamepadButton(I)Z

    move-result v0

    :goto_0
    return v0

    .line 329
    :pswitch_0
    const/4 v0, 0x1

    goto :goto_0

    .line 322
    :pswitch_data_0
    .packed-switch 0x13
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method


# virtual methods
.method public getInputControl(I)Lcom/adobe/air/AndroidInputControl;
    .locals 1
    .param p1, "index"    # I

    .prologue
    .line 317
    iget-object v0, p0, Lcom/adobe/air/AndroidInputDevice;->mInputControls:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/adobe/air/AndroidInputControl;

    return-object v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 298
    iget-object v0, p0, Lcom/adobe/air/AndroidInputDevice;->mDevice:Landroid/view/InputDevice;

    invoke-virtual {v0}, Landroid/view/InputDevice;->getName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getNumControls()I
    .locals 1

    .prologue
    .line 310
    iget v0, p0, Lcom/adobe/air/AndroidInputDevice;->mNumControls:I

    return v0
.end method

.method public getUniqueId()Ljava/lang/String;
    .locals 1

    .prologue
    .line 303
    iget-object v0, p0, Lcom/adobe/air/AndroidInputDevice;->mDevice:Landroid/view/InputDevice;

    invoke-virtual {v0}, Landroid/view/InputDevice;->getDescriptor()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public onGenericMotionEvent(Landroid/view/MotionEvent;)Z
    .locals 5
    .param p1, "event"    # Landroid/view/MotionEvent;

    .prologue
    .line 370
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget-object v3, p0, Lcom/adobe/air/AndroidInputDevice;->mInputControls:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    if-ge v0, v3, :cond_1

    .line 372
    iget-object v3, p0, Lcom/adobe/air/AndroidInputDevice;->mInputControls:Ljava/util/List;

    invoke-interface {v3, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/adobe/air/AndroidInputControl;

    .line 373
    .local v1, "inputControl":Lcom/adobe/air/AndroidInputControl;
    invoke-virtual {v1}, Lcom/adobe/air/AndroidInputControl;->getType()I

    move-result v3

    sget-object v4, Lcom/adobe/air/ControlType;->AXIS:Lcom/adobe/air/ControlType;

    invoke-virtual {v4}, Lcom/adobe/air/ControlType;->ordinal()I

    move-result v4

    if-ne v3, v4, :cond_0

    .line 375
    invoke-virtual {v1}, Lcom/adobe/air/AndroidInputControl;->getCode()I

    move-result v3

    invoke-virtual {p1, v3}, Landroid/view/MotionEvent;->getAxisValue(I)F

    move-result v2

    .line 376
    .local v2, "value":F
    invoke-virtual {v1, v2}, Lcom/adobe/air/AndroidInputControl;->setData(F)V

    .line 370
    .end local v2    # "value":F
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 379
    .end local v1    # "inputControl":Lcom/adobe/air/AndroidInputControl;
    :cond_1
    const/4 v3, 0x1

    return v3
.end method

.method public onKeyEvent(Landroid/view/KeyEvent;)Z
    .locals 5
    .param p1, "event"    # Landroid/view/KeyEvent;

    .prologue
    const/4 v2, 0x1

    .line 343
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget-object v3, p0, Lcom/adobe/air/AndroidInputDevice;->mInputControls:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    if-ge v0, v3, :cond_1

    .line 345
    iget-object v3, p0, Lcom/adobe/air/AndroidInputDevice;->mInputControls:Ljava/util/List;

    invoke-interface {v3, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/adobe/air/AndroidInputControl;

    .line 346
    .local v1, "inputControl":Lcom/adobe/air/AndroidInputControl;
    invoke-virtual {v1}, Lcom/adobe/air/AndroidInputControl;->getType()I

    move-result v3

    sget-object v4, Lcom/adobe/air/ControlType;->BUTTON:Lcom/adobe/air/ControlType;

    invoke-virtual {v4}, Lcom/adobe/air/ControlType;->ordinal()I

    move-result v4

    if-ne v3, v4, :cond_0

    .line 347
    invoke-virtual {v1}, Lcom/adobe/air/AndroidInputControl;->getCode()I

    move-result v3

    invoke-virtual {p1}, Landroid/view/KeyEvent;->getKeyCode()I

    move-result v4

    if-ne v3, v4, :cond_0

    .line 351
    invoke-virtual {p1}, Landroid/view/KeyEvent;->getAction()I

    move-result v3

    packed-switch v3, :pswitch_data_0

    .line 343
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 354
    :pswitch_0
    const/high16 v3, 0x3f800000    # 1.0f

    invoke-virtual {v1, v3}, Lcom/adobe/air/AndroidInputControl;->setData(F)V

    .line 362
    .end local v1    # "inputControl":Lcom/adobe/air/AndroidInputControl;
    :goto_1
    return v2

    .line 357
    .restart local v1    # "inputControl":Lcom/adobe/air/AndroidInputControl;
    :pswitch_1
    const/4 v3, 0x0

    invoke-virtual {v1, v3}, Lcom/adobe/air/AndroidInputControl;->setData(F)V

    goto :goto_1

    .line 362
    .end local v1    # "inputControl":Lcom/adobe/air/AndroidInputControl;
    :cond_1
    const/4 v2, 0x0

    goto :goto_1

    .line 351
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.class public Lcom/adobe/air/wand/view/CompanionView;
.super Landroid/view/View;
.source "CompanionView.java"


# static fields
.field private static final LOG_TAG:Ljava/lang/String; = "CompanionView"

.field static final POST_TOUCH_MESSAGE_AFTER_DELAY:I = 0x0

.field public static final kTouchActionBegin:I = 0x2

.field public static final kTouchActionEnd:I = 0x4

.field public static final kTouchActionMove:I = 0x1

.field public static final kTouchMetaStateIsEraser:I = 0x4000000

.field public static final kTouchMetaStateIsPen:I = 0x2000000

.field public static final kTouchMetaStateMask:I = 0xe000000

.field public static final kTouchMetaStateSideButton1:I = 0x8000000


# instance fields
.field public final kMultitouchGesture:I

.field public final kMultitouchNone:I

.field public final kMultitouchRaw:I

.field private mBoundHeight:I

.field private mBoundWidth:I

.field private mCurrentOrientation:I

.field private mGestureDetector:Landroid/view/GestureDetector;

.field private mGestureListener:Lcom/adobe/air/wand/view/GestureListener;

.field private mIsFullScreen:Z

.field private mMultitouchMode:I

.field private mScaleGestureDetector:Landroid/view/ScaleGestureDetector;

.field private mSkipHeightFromTop:I

.field private mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

.field private mVisibleBoundHeight:I

.field private mVisibleBoundWidth:I


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v2, 0x2

    const/4 v1, 0x0

    .line 77
    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 42
    iput v1, p0, Lcom/adobe/air/wand/view/CompanionView;->kMultitouchNone:I

    .line 43
    const/4 v0, 0x1

    iput v0, p0, Lcom/adobe/air/wand/view/CompanionView;->kMultitouchRaw:I

    .line 44
    iput v2, p0, Lcom/adobe/air/wand/view/CompanionView;->kMultitouchGesture:I

    .line 52
    iput v1, p0, Lcom/adobe/air/wand/view/CompanionView;->mSkipHeightFromTop:I

    .line 53
    iput v1, p0, Lcom/adobe/air/wand/view/CompanionView;->mBoundHeight:I

    .line 54
    iput v1, p0, Lcom/adobe/air/wand/view/CompanionView;->mBoundWidth:I

    .line 55
    iput v1, p0, Lcom/adobe/air/wand/view/CompanionView;->mVisibleBoundWidth:I

    .line 56
    iput v1, p0, Lcom/adobe/air/wand/view/CompanionView;->mVisibleBoundHeight:I

    .line 62
    iput v2, p0, Lcom/adobe/air/wand/view/CompanionView;->mMultitouchMode:I

    .line 68
    iput v1, p0, Lcom/adobe/air/wand/view/CompanionView;->mCurrentOrientation:I

    .line 69
    iput-boolean v1, p0, Lcom/adobe/air/wand/view/CompanionView;->mIsFullScreen:Z

    .line 71
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/wand/view/CompanionView;->mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

    .line 79
    invoke-direct {p0, p1}, Lcom/adobe/air/wand/view/CompanionView;->initView(Landroid/content/Context;)V

    .line 80
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attr"    # Landroid/util/AttributeSet;

    .prologue
    const/4 v2, 0x2

    const/4 v1, 0x0

    .line 84
    invoke-direct {p0, p1, p2}, Landroid/view/View;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 42
    iput v1, p0, Lcom/adobe/air/wand/view/CompanionView;->kMultitouchNone:I

    .line 43
    const/4 v0, 0x1

    iput v0, p0, Lcom/adobe/air/wand/view/CompanionView;->kMultitouchRaw:I

    .line 44
    iput v2, p0, Lcom/adobe/air/wand/view/CompanionView;->kMultitouchGesture:I

    .line 52
    iput v1, p0, Lcom/adobe/air/wand/view/CompanionView;->mSkipHeightFromTop:I

    .line 53
    iput v1, p0, Lcom/adobe/air/wand/view/CompanionView;->mBoundHeight:I

    .line 54
    iput v1, p0, Lcom/adobe/air/wand/view/CompanionView;->mBoundWidth:I

    .line 55
    iput v1, p0, Lcom/adobe/air/wand/view/CompanionView;->mVisibleBoundWidth:I

    .line 56
    iput v1, p0, Lcom/adobe/air/wand/view/CompanionView;->mVisibleBoundHeight:I

    .line 62
    iput v2, p0, Lcom/adobe/air/wand/view/CompanionView;->mMultitouchMode:I

    .line 68
    iput v1, p0, Lcom/adobe/air/wand/view/CompanionView;->mCurrentOrientation:I

    .line 69
    iput-boolean v1, p0, Lcom/adobe/air/wand/view/CompanionView;->mIsFullScreen:Z

    .line 71
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/wand/view/CompanionView;->mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

    .line 86
    invoke-direct {p0, p1}, Lcom/adobe/air/wand/view/CompanionView;->initView(Landroid/content/Context;)V

    .line 87
    return-void
.end method

.method private IsTouchEventHandlingAllowed(IFF)Z
    .locals 1
    .param p1, "stage"    # I
    .param p2, "xCoord"    # F
    .param p3, "yCoord"    # F

    .prologue
    .line 408
    const/4 v0, 0x1

    return v0
.end method

.method private initView(Landroid/content/Context;)V
    .locals 5
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v4, 0x0

    const/4 v3, 0x1

    .line 91
    new-instance v0, Lcom/adobe/air/wand/view/TouchSensor;

    invoke-direct {v0}, Lcom/adobe/air/wand/view/TouchSensor;-><init>()V

    iput-object v0, p0, Lcom/adobe/air/wand/view/CompanionView;->mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

    .line 93
    new-instance v0, Lcom/adobe/air/wand/view/GestureListener;

    invoke-direct {v0, p1, p0}, Lcom/adobe/air/wand/view/GestureListener;-><init>(Landroid/content/Context;Lcom/adobe/air/wand/view/CompanionView;)V

    iput-object v0, p0, Lcom/adobe/air/wand/view/CompanionView;->mGestureListener:Lcom/adobe/air/wand/view/GestureListener;

    .line 94
    new-instance v0, Landroid/view/GestureDetector;

    iget-object v1, p0, Lcom/adobe/air/wand/view/CompanionView;->mGestureListener:Lcom/adobe/air/wand/view/GestureListener;

    const/4 v2, 0x0

    invoke-direct {v0, p1, v1, v2, v4}, Landroid/view/GestureDetector;-><init>(Landroid/content/Context;Landroid/view/GestureDetector$OnGestureListener;Landroid/os/Handler;Z)V

    iput-object v0, p0, Lcom/adobe/air/wand/view/CompanionView;->mGestureDetector:Landroid/view/GestureDetector;

    .line 95
    new-instance v0, Landroid/view/ScaleGestureDetector;

    iget-object v1, p0, Lcom/adobe/air/wand/view/CompanionView;->mGestureListener:Lcom/adobe/air/wand/view/GestureListener;

    invoke-direct {v0, p1, v1}, Landroid/view/ScaleGestureDetector;-><init>(Landroid/content/Context;Landroid/view/ScaleGestureDetector$OnScaleGestureListener;)V

    iput-object v0, p0, Lcom/adobe/air/wand/view/CompanionView;->mScaleGestureDetector:Landroid/view/ScaleGestureDetector;

    .line 97
    invoke-virtual {p0, v4}, Lcom/adobe/air/wand/view/CompanionView;->setWillNotDraw(Z)V

    .line 99
    invoke-virtual {p0, v3}, Lcom/adobe/air/wand/view/CompanionView;->setClickable(Z)V

    .line 100
    invoke-virtual {p0, v3}, Lcom/adobe/air/wand/view/CompanionView;->setEnabled(Z)V

    .line 101
    invoke-virtual {p0, v3}, Lcom/adobe/air/wand/view/CompanionView;->setFocusable(Z)V

    .line 102
    invoke-virtual {p0, v3}, Lcom/adobe/air/wand/view/CompanionView;->setFocusableInTouchMode(Z)V

    .line 103
    return-void
.end method


# virtual methods
.method public IsLandScape()Z
    .locals 2

    .prologue
    .line 403
    iget v0, p0, Lcom/adobe/air/wand/view/CompanionView;->mCurrentOrientation:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public IsTouchUpHandlingAllowed()Z
    .locals 1

    .prologue
    .line 413
    const/4 v0, 0x1

    return v0
.end method

.method public getBoundHeight()I
    .locals 1

    .prologue
    .line 386
    iget v0, p0, Lcom/adobe/air/wand/view/CompanionView;->mBoundHeight:I

    return v0
.end method

.method public getBoundWidth()I
    .locals 1

    .prologue
    .line 380
    iget v0, p0, Lcom/adobe/air/wand/view/CompanionView;->mBoundWidth:I

    return v0
.end method

.method public getIsFullScreen()Z
    .locals 1

    .prologue
    .line 375
    iget-boolean v0, p0, Lcom/adobe/air/wand/view/CompanionView;->mIsFullScreen:Z

    return v0
.end method

.method public getMultitouchMode()I
    .locals 1

    .prologue
    .line 370
    iget v0, p0, Lcom/adobe/air/wand/view/CompanionView;->mMultitouchMode:I

    return v0
.end method

.method public getTouchSensor()Lcom/adobe/air/wand/view/TouchSensor;
    .locals 1

    .prologue
    .line 353
    iget-object v0, p0, Lcom/adobe/air/wand/view/CompanionView;->mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

    return-object v0
.end method

.method public getVisibleBoundHeight()I
    .locals 1

    .prologue
    .line 398
    iget v0, p0, Lcom/adobe/air/wand/view/CompanionView;->mVisibleBoundHeight:I

    return v0
.end method

.method public getVisibleBoundWidth()I
    .locals 1

    .prologue
    .line 392
    iget v0, p0, Lcom/adobe/air/wand/view/CompanionView;->mVisibleBoundWidth:I

    return v0
.end method

.method protected onFocusChanged(ZILandroid/graphics/Rect;)V
    .locals 0
    .param p1, "focused"    # Z
    .param p2, "direction"    # I
    .param p3, "previouslyFocusedRect"    # Landroid/graphics/Rect;

    .prologue
    .line 130
    invoke-super {p0, p1, p2, p3}, Landroid/view/View;->onFocusChanged(ZILandroid/graphics/Rect;)V

    .line 131
    return-void
.end method

.method public onGestureListener(IIZFFFFFFF)V
    .locals 11
    .param p1, "gesturePhase"    # I
    .param p2, "gestureType"    # I
    .param p3, "isTransform"    # Z
    .param p4, "locX"    # F
    .param p5, "locY"    # F
    .param p6, "scaleX"    # F
    .param p7, "scaleY"    # F
    .param p8, "rotation"    # F
    .param p9, "offsetX"    # F
    .param p10, "offsetY"    # F

    .prologue
    .line 343
    new-instance v0, Lcom/adobe/air/wand/view/GestureEventData;

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move/from16 v5, p5

    move/from16 v6, p6

    move/from16 v7, p7

    move/from16 v8, p8

    move/from16 v9, p9

    move/from16 v10, p10

    invoke-direct/range {v0 .. v10}, Lcom/adobe/air/wand/view/GestureEventData;-><init>(IIZFFFFFFF)V

    .line 348
    .local v0, "gestureEvent":Lcom/adobe/air/wand/view/GestureEventData;
    iget-object v1, p0, Lcom/adobe/air/wand/view/CompanionView;->mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

    invoke-virtual {v1, v0}, Lcom/adobe/air/wand/view/TouchSensor;->dispatchEvent(Lcom/adobe/air/wand/view/GestureEventData;)V

    .line 349
    return-void
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 1
    .param p1, "keyCode"    # I
    .param p2, "event"    # Landroid/view/KeyEvent;

    .prologue
    .line 118
    const/4 v0, 0x0

    return v0
.end method

.method public onKeyUp(ILandroid/view/KeyEvent;)Z
    .locals 1
    .param p1, "keyCode"    # I
    .param p2, "event"    # Landroid/view/KeyEvent;

    .prologue
    .line 124
    const/4 v0, 0x0

    return v0
.end method

.method protected onSizeChanged(IIII)V
    .locals 0
    .param p1, "width"    # I
    .param p2, "height"    # I
    .param p3, "oldWidth"    # I
    .param p4, "oldHeight"    # I

    .prologue
    .line 359
    invoke-super {p0, p1, p2, p3, p4}, Landroid/view/View;->onSizeChanged(IIII)V

    .line 361
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 39
    .param p1, "e"    # Landroid/view/MotionEvent;

    .prologue
    .line 136
    const/16 v37, 0x1

    .line 137
    .local v37, "retVal":Z
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v26

    .line 138
    .local v26, "actionCode":I
    move/from16 v0, v26

    and-int/lit16 v0, v0, 0xff

    move/from16 v26, v0

    .line 139
    const/16 v31, 0x0

    .line 141
    .local v31, "isHoverEvent":Z
    if-nez v31, :cond_3

    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/adobe/air/wand/view/CompanionView;->mGestureListener:Lcom/adobe/air/wand/view/GestureListener;

    if-eqz v12, :cond_3

    .line 144
    const/4 v12, 0x5

    move/from16 v0, v26

    if-eq v0, v12, :cond_0

    if-nez v26, :cond_1

    .line 146
    :cond_0
    const/16 v30, 0x0

    .local v30, "i":I
    :goto_0
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v12

    move/from16 v0, v30

    if-ge v0, v12, :cond_1

    .line 148
    move-object/from16 v0, p1

    move/from16 v1, v30

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v32

    .line 149
    .local v32, "pid":I
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/adobe/air/wand/view/CompanionView;->mGestureListener:Lcom/adobe/air/wand/view/GestureListener;

    move-object/from16 v0, p1

    move/from16 v1, v30

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getX(I)F

    move-result v14

    move-object/from16 v0, p1

    move/from16 v1, v30

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getY(I)F

    move-result v16

    move/from16 v0, v16

    move/from16 v1, v32

    invoke-virtual {v12, v14, v0, v1}, Lcom/adobe/air/wand/view/GestureListener;->setDownTouchPoint(FFI)V

    .line 146
    add-int/lit8 v30, v30, 0x1

    goto :goto_0

    .line 155
    .end local v30    # "i":I
    .end local v32    # "pid":I
    :cond_1
    if-nez v26, :cond_2

    .line 157
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/adobe/air/wand/view/CompanionView;->mGestureListener:Lcom/adobe/air/wand/view/GestureListener;

    invoke-virtual {v12}, Lcom/adobe/air/wand/view/GestureListener;->mayStartNewTransformGesture()V

    .line 160
    :cond_2
    const/4 v12, 0x5

    move/from16 v0, v26

    if-ne v0, v12, :cond_7

    .line 162
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/adobe/air/wand/view/CompanionView;->mGestureListener:Lcom/adobe/air/wand/view/GestureListener;

    const/4 v14, 0x1

    invoke-virtual {v12, v14}, Lcom/adobe/air/wand/view/GestureListener;->setCouldBeTwoFingerTap(I)V

    .line 164
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/adobe/air/wand/view/CompanionView;->mGestureListener:Lcom/adobe/air/wand/view/GestureListener;

    const/4 v14, 0x0

    move-object/from16 v0, p1

    invoke-virtual {v0, v14}, Landroid/view/MotionEvent;->getX(I)F

    move-result v14

    const/16 v16, 0x0

    move-object/from16 v0, p1

    move/from16 v1, v16

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getY(I)F

    move-result v16

    const/16 v17, 0x0

    move-object/from16 v0, p1

    move/from16 v1, v17

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v17

    move/from16 v0, v16

    move/from16 v1, v17

    invoke-virtual {v12, v14, v0, v1}, Lcom/adobe/air/wand/view/GestureListener;->setPrimaryPointOfTwoFingerTap(FFI)V

    .line 166
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/adobe/air/wand/view/CompanionView;->mGestureListener:Lcom/adobe/air/wand/view/GestureListener;

    const/4 v14, 0x1

    move-object/from16 v0, p1

    invoke-virtual {v0, v14}, Landroid/view/MotionEvent;->getX(I)F

    move-result v14

    const/16 v16, 0x1

    move-object/from16 v0, p1

    move/from16 v1, v16

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getY(I)F

    move-result v16

    const/16 v17, 0x1

    move-object/from16 v0, p1

    move/from16 v1, v17

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v17

    move/from16 v0, v16

    move/from16 v1, v17

    invoke-virtual {v12, v14, v0, v1}, Lcom/adobe/air/wand/view/GestureListener;->setSecondaryPointOfTwoFingerTap(FFI)V

    .line 177
    :cond_3
    :goto_1
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v33

    .line 181
    .local v33, "pointerCount":I
    const/16 v27, 0x0

    .line 183
    .local v27, "cancelAllTouch":Z
    const/16 v34, 0x0

    .local v34, "pointerIndex":I
    :goto_2
    move/from16 v0, v34

    move/from16 v1, v33

    if-ge v0, v1, :cond_12

    .line 185
    move-object/from16 v0, p1

    move/from16 v1, v34

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getX(I)F

    move-result v5

    .line 186
    .local v5, "xCoord":F
    move-object/from16 v0, p1

    move/from16 v1, v34

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getY(I)F

    move-result v12

    move-object/from16 v0, p0

    iget v14, v0, Lcom/adobe/air/wand/view/CompanionView;->mSkipHeightFromTop:I

    int-to-float v14, v14

    add-float v6, v12, v14

    .line 188
    .local v6, "yCoord":F
    const/4 v4, 0x1

    .line 189
    .local v4, "stage":I
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v25

    .line 190
    .local v25, "action":I
    move-object/from16 v0, p1

    move/from16 v1, v34

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v8

    .line 192
    .local v8, "pointerId":I
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getMetaState()I

    move-result v13

    .line 194
    .local v13, "metaState":I
    sget v12, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v14, 0xe

    if-lt v12, v14, :cond_5

    .line 195
    const v12, -0xe000001

    and-int/2addr v13, v12

    .line 196
    move-object/from16 v0, p1

    move/from16 v1, v34

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getToolType(I)I

    move-result v38

    .line 197
    .local v38, "toolType":I
    const/4 v12, 0x4

    move/from16 v0, v38

    if-ne v0, v12, :cond_a

    .line 198
    const/high16 v12, 0x4000000

    or-int/2addr v13, v12

    .line 202
    :cond_4
    :goto_3
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getButtonState()I

    move-result v12

    and-int/lit8 v12, v12, 0x2

    if-eqz v12, :cond_5

    .line 203
    const/high16 v12, 0x8000000

    or-int/2addr v13, v12

    .line 206
    .end local v38    # "toolType":I
    :cond_5
    if-eqz v27, :cond_b

    .line 208
    const/16 v25, 0x3

    .line 209
    const/4 v4, 0x4

    .line 240
    :cond_6
    :goto_4
    move-object/from16 v0, p0

    invoke-direct {v0, v4, v5, v6}, Lcom/adobe/air/wand/view/CompanionView;->IsTouchEventHandlingAllowed(IFF)Z

    move-result v12

    if-eqz v12, :cond_11

    .line 243
    move-object/from16 v0, p1

    move/from16 v1, v34

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getSize(I)F

    move-result v9

    .line 244
    .local v9, "contactWidth":F
    move v10, v9

    .line 246
    .local v10, "contactHeight":F
    if-nez v8, :cond_d

    const/4 v11, 0x1

    .line 249
    .local v11, "isPrimaryPoint":Z
    :goto_5
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getHistorySize()I

    move-result v29

    .line 250
    .local v29, "historySize":I
    add-int/lit8 v12, v29, 0x1

    mul-int/lit8 v12, v12, 0x3

    new-array v0, v12, [F

    move-object/from16 v23, v0

    .line 251
    .local v23, "history":[F
    const/16 v35, 0x0

    .line 252
    .local v35, "recordIndex":I
    const/16 v28, 0x0

    .local v28, "historyIndex":I
    move/from16 v36, v35

    .end local v35    # "recordIndex":I
    .local v36, "recordIndex":I
    :goto_6
    move/from16 v0, v28

    move/from16 v1, v29

    if-ge v0, v1, :cond_e

    .line 254
    add-int/lit8 v35, v36, 0x1

    .end local v36    # "recordIndex":I
    .restart local v35    # "recordIndex":I
    move-object/from16 v0, p1

    move/from16 v1, v34

    move/from16 v2, v28

    invoke-virtual {v0, v1, v2}, Landroid/view/MotionEvent;->getHistoricalX(II)F

    move-result v12

    aput v12, v23, v36

    .line 255
    add-int/lit8 v36, v35, 0x1

    .end local v35    # "recordIndex":I
    .restart local v36    # "recordIndex":I
    move-object/from16 v0, p1

    move/from16 v1, v34

    move/from16 v2, v28

    invoke-virtual {v0, v1, v2}, Landroid/view/MotionEvent;->getHistoricalY(II)F

    move-result v12

    aput v12, v23, v35

    .line 256
    add-int/lit8 v35, v36, 0x1

    .end local v36    # "recordIndex":I
    .restart local v35    # "recordIndex":I
    move-object/from16 v0, p1

    move/from16 v1, v34

    move/from16 v2, v28

    invoke-virtual {v0, v1, v2}, Landroid/view/MotionEvent;->getHistoricalPressure(II)F

    move-result v12

    aput v12, v23, v36

    .line 252
    add-int/lit8 v28, v28, 0x1

    move/from16 v36, v35

    .end local v35    # "recordIndex":I
    .restart local v36    # "recordIndex":I
    goto :goto_6

    .line 168
    .end local v4    # "stage":I
    .end local v5    # "xCoord":F
    .end local v6    # "yCoord":F
    .end local v8    # "pointerId":I
    .end local v9    # "contactWidth":F
    .end local v10    # "contactHeight":F
    .end local v11    # "isPrimaryPoint":Z
    .end local v13    # "metaState":I
    .end local v23    # "history":[F
    .end local v25    # "action":I
    .end local v27    # "cancelAllTouch":Z
    .end local v28    # "historyIndex":I
    .end local v29    # "historySize":I
    .end local v33    # "pointerCount":I
    .end local v34    # "pointerIndex":I
    .end local v36    # "recordIndex":I
    :cond_7
    const/4 v12, 0x6

    move/from16 v0, v26

    if-ne v0, v12, :cond_8

    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/adobe/air/wand/view/CompanionView;->mGestureListener:Lcom/adobe/air/wand/view/GestureListener;

    invoke-virtual {v12}, Lcom/adobe/air/wand/view/GestureListener;->getCouldBeTwoFingerTap()I

    move-result v12

    const/4 v14, 0x1

    if-ne v12, v14, :cond_8

    .line 169
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/adobe/air/wand/view/CompanionView;->mGestureListener:Lcom/adobe/air/wand/view/GestureListener;

    const/4 v14, 0x2

    invoke-virtual {v12, v14}, Lcom/adobe/air/wand/view/GestureListener;->setCouldBeTwoFingerTap(I)V

    goto/16 :goto_1

    .line 170
    :cond_8
    const/4 v12, 0x1

    move/from16 v0, v26

    if-ne v0, v12, :cond_9

    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/adobe/air/wand/view/CompanionView;->mGestureListener:Lcom/adobe/air/wand/view/GestureListener;

    invoke-virtual {v12}, Lcom/adobe/air/wand/view/GestureListener;->getCouldBeTwoFingerTap()I

    move-result v12

    const/4 v14, 0x2

    if-ne v12, v14, :cond_9

    .line 171
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/adobe/air/wand/view/CompanionView;->mGestureListener:Lcom/adobe/air/wand/view/GestureListener;

    const/4 v14, 0x3

    invoke-virtual {v12, v14}, Lcom/adobe/air/wand/view/GestureListener;->setCouldBeTwoFingerTap(I)V

    goto/16 :goto_1

    .line 172
    :cond_9
    const/4 v12, 0x2

    move/from16 v0, v26

    if-eq v0, v12, :cond_3

    .line 173
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/adobe/air/wand/view/CompanionView;->mGestureListener:Lcom/adobe/air/wand/view/GestureListener;

    const/4 v14, 0x0

    invoke-virtual {v12, v14}, Lcom/adobe/air/wand/view/GestureListener;->setCouldBeTwoFingerTap(I)V

    goto/16 :goto_1

    .line 200
    .restart local v4    # "stage":I
    .restart local v5    # "xCoord":F
    .restart local v6    # "yCoord":F
    .restart local v8    # "pointerId":I
    .restart local v13    # "metaState":I
    .restart local v25    # "action":I
    .restart local v27    # "cancelAllTouch":Z
    .restart local v33    # "pointerCount":I
    .restart local v34    # "pointerIndex":I
    .restart local v38    # "toolType":I
    :cond_a
    const/4 v12, 0x2

    move/from16 v0, v38

    if-ne v0, v12, :cond_4

    .line 201
    const/high16 v12, 0x2000000

    or-int/2addr v13, v12

    goto/16 :goto_3

    .line 211
    .end local v38    # "toolType":I
    :cond_b
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v12

    const/4 v14, 0x1

    if-eq v12, v14, :cond_c

    const v12, 0xff00

    and-int v12, v12, v25

    shr-int/lit8 v12, v12, 0x8

    .line 212
    move-object/from16 v0, p1

    invoke-virtual {v0, v12}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v12

    if-ne v8, v12, :cond_6

    .line 214
    :cond_c
    move/from16 v0, v25

    and-int/lit16 v0, v0, 0xff

    move/from16 v25, v0

    .line 216
    packed-switch v25, :pswitch_data_0

    .line 235
    :pswitch_0
    const/4 v4, 0x1

    goto/16 :goto_4

    .line 220
    :pswitch_1
    const/4 v4, 0x2

    .line 221
    goto/16 :goto_4

    .line 223
    :pswitch_2
    const/16 v27, 0x1

    .line 226
    :pswitch_3
    const/4 v4, 0x4

    .line 228
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/adobe/air/wand/view/CompanionView;->mGestureListener:Lcom/adobe/air/wand/view/GestureListener;

    if-eqz v12, :cond_6

    .line 230
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/adobe/air/wand/view/CompanionView;->mGestureListener:Lcom/adobe/air/wand/view/GestureListener;

    invoke-virtual {v12}, Lcom/adobe/air/wand/view/GestureListener;->endTwoFingerGesture()Z

    .line 231
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/adobe/air/wand/view/CompanionView;->mGestureListener:Lcom/adobe/air/wand/view/GestureListener;

    const/4 v14, 0x1

    invoke-virtual {v12, v14}, Lcom/adobe/air/wand/view/GestureListener;->setCheckForSwipe(Z)V

    goto/16 :goto_4

    .line 246
    .restart local v9    # "contactWidth":F
    .restart local v10    # "contactHeight":F
    :cond_d
    const/4 v11, 0x0

    goto/16 :goto_5

    .line 259
    .restart local v11    # "isPrimaryPoint":Z
    .restart local v23    # "history":[F
    .restart local v28    # "historyIndex":I
    .restart local v29    # "historySize":I
    .restart local v36    # "recordIndex":I
    :cond_e
    move-object/from16 v0, p1

    move/from16 v1, v34

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getPressure(I)F

    move-result v7

    .line 262
    .local v7, "pressure":F
    aput v5, v23, v36

    .line 263
    add-int/lit8 v12, v36, 0x1

    aput v6, v23, v12

    .line 264
    add-int/lit8 v12, v36, 0x2

    aput v7, v23, v12

    .line 267
    and-int/lit8 v13, v13, -0x2

    .line 269
    const/4 v12, 0x1

    if-eq v4, v12, :cond_10

    .line 271
    const/4 v12, 0x3

    move/from16 v0, v25

    if-ne v0, v12, :cond_f

    .line 273
    or-int/lit8 v13, v13, 0x1

    .line 276
    :cond_f
    new-instance v3, Lcom/adobe/air/TouchEventData;

    const/4 v12, 0x0

    invoke-direct/range {v3 .. v13}, Lcom/adobe/air/TouchEventData;-><init>(IFFFIFFZ[FI)V

    .line 286
    .local v3, "touchEventData":Lcom/adobe/air/TouchEventData;
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/adobe/air/wand/view/CompanionView;->mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

    invoke-virtual {v12, v3}, Lcom/adobe/air/wand/view/TouchSensor;->dispatchEvent(Lcom/adobe/air/TouchEventData;)V

    .line 290
    .end local v3    # "touchEventData":Lcom/adobe/air/TouchEventData;
    :cond_10
    const/4 v15, 0x0

    .line 291
    .local v15, "moveAction":I
    packed-switch v4, :pswitch_data_1

    .line 301
    :goto_7
    if-eqz v15, :cond_11

    .line 303
    new-instance v3, Lcom/adobe/air/TouchEventData;

    move-object v14, v3

    move/from16 v16, v5

    move/from16 v17, v6

    move/from16 v18, v7

    move/from16 v19, v8

    move/from16 v20, v9

    move/from16 v21, v10

    move/from16 v22, v11

    move/from16 v24, v13

    invoke-direct/range {v14 .. v24}, Lcom/adobe/air/TouchEventData;-><init>(IFFFIFFZ[FI)V

    .line 313
    .restart local v3    # "touchEventData":Lcom/adobe/air/TouchEventData;
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/adobe/air/wand/view/CompanionView;->mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

    invoke-virtual {v12, v3}, Lcom/adobe/air/wand/view/TouchSensor;->dispatchEvent(Lcom/adobe/air/TouchEventData;)V

    .line 183
    .end local v3    # "touchEventData":Lcom/adobe/air/TouchEventData;
    .end local v7    # "pressure":F
    .end local v9    # "contactWidth":F
    .end local v10    # "contactHeight":F
    .end local v11    # "isPrimaryPoint":Z
    .end local v15    # "moveAction":I
    .end local v23    # "history":[F
    .end local v28    # "historyIndex":I
    .end local v29    # "historySize":I
    .end local v36    # "recordIndex":I
    :cond_11
    add-int/lit8 v34, v34, 0x1

    goto/16 :goto_2

    .line 295
    .restart local v7    # "pressure":F
    .restart local v9    # "contactWidth":F
    .restart local v10    # "contactHeight":F
    .restart local v11    # "isPrimaryPoint":Z
    .restart local v15    # "moveAction":I
    .restart local v23    # "history":[F
    .restart local v28    # "historyIndex":I
    .restart local v29    # "historySize":I
    .restart local v36    # "recordIndex":I
    :pswitch_4
    const/4 v15, 0x1

    .line 296
    goto :goto_7

    .line 318
    .end local v4    # "stage":I
    .end local v5    # "xCoord":F
    .end local v6    # "yCoord":F
    .end local v7    # "pressure":F
    .end local v8    # "pointerId":I
    .end local v9    # "contactWidth":F
    .end local v10    # "contactHeight":F
    .end local v11    # "isPrimaryPoint":Z
    .end local v13    # "metaState":I
    .end local v15    # "moveAction":I
    .end local v23    # "history":[F
    .end local v25    # "action":I
    .end local v28    # "historyIndex":I
    .end local v29    # "historySize":I
    .end local v36    # "recordIndex":I
    :cond_12
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/adobe/air/wand/view/CompanionView;->mScaleGestureDetector:Landroid/view/ScaleGestureDetector;

    if-eqz v12, :cond_13

    .line 322
    if-eqz v37, :cond_15

    :try_start_0
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/adobe/air/wand/view/CompanionView;->mScaleGestureDetector:Landroid/view/ScaleGestureDetector;

    move-object/from16 v0, p1

    invoke-virtual {v12, v0}, Landroid/view/ScaleGestureDetector;->onTouchEvent(Landroid/view/MotionEvent;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v12

    if-eqz v12, :cond_15

    const/16 v37, 0x1

    .line 330
    :cond_13
    :goto_8
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/adobe/air/wand/view/CompanionView;->mGestureDetector:Landroid/view/GestureDetector;

    if-eqz v12, :cond_14

    .line 332
    if-eqz v37, :cond_16

    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/adobe/air/wand/view/CompanionView;->mGestureDetector:Landroid/view/GestureDetector;

    move-object/from16 v0, p1

    invoke-virtual {v12, v0}, Landroid/view/GestureDetector;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v12

    if-eqz v12, :cond_16

    const/16 v37, 0x1

    .line 335
    :cond_14
    :goto_9
    return v37

    .line 322
    :cond_15
    const/16 v37, 0x0

    goto :goto_8

    .line 332
    :cond_16
    const/16 v37, 0x0

    goto :goto_9

    .line 324
    :catch_0
    move-exception v12

    goto :goto_8

    .line 216
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_3
        :pswitch_0
        :pswitch_2
        :pswitch_0
        :pswitch_1
        :pswitch_3
    .end packed-switch

    .line 291
    :pswitch_data_1
    .packed-switch 0x1
        :pswitch_4
        :pswitch_4
    .end packed-switch
.end method

.method public onWindowFocusChanged(Z)V
    .locals 0
    .param p1, "hasWindowFocus"    # Z

    .prologue
    .line 113
    return-void
.end method

.method public returnThis()Landroid/view/View;
    .locals 0

    .prologue
    .line 107
    return-object p0
.end method

.method public setMultitouchMode(I)V
    .locals 0
    .param p1, "multitouchMode"    # I

    .prologue
    .line 365
    iput p1, p0, Lcom/adobe/air/wand/view/CompanionView;->mMultitouchMode:I

    .line 366
    return-void
.end method

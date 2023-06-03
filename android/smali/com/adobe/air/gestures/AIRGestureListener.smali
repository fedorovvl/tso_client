.class public Lcom/adobe/air/gestures/AIRGestureListener;
.super Ljava/lang/Object;
.source "AIRGestureListener.java"

# interfaces
.implements Landroid/view/GestureDetector$OnGestureListener;
.implements Landroid/view/GestureDetector$OnDoubleTapListener;
.implements Landroid/view/ScaleGestureDetector$OnScaleGestureListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;
    }
.end annotation


# static fields
.field private static final LOG_TAG:Ljava/lang/String; = "AIRGestureListener"

.field private static final MAX_TOUCH_POINTS:I = 0x2

.field private static final MM_PER_INCH:F = 25.4f

.field private static final _FP_GESTURE_PAN_THRESHOLD_MM:F = 3.0f

.field private static final _FP_GESTURE_ROTATION_THRESHOLD_DEGREES:F = 15.0f

.field private static final _FP_GESTURE_SWIPE_PRIMARY_AXIS_MIN_MM:F = 10.0f

.field private static final _FP_GESTURE_SWIPE_SECONDARY_AXIS_MAX_MM:F = 5.0f

.field private static final _FP_GESTURE_ZOOM_PER_AXIS_THRESHOLD_MM:F = 3.0f

.field private static final _FP_GESTURE_ZOOM_THRESHOLD_MM:F = 8.0f

.field private static final kGestureAll:I = 0x8

.field private static final kGestureBegin:I = 0x2

.field private static final kGestureEnd:I = 0x4

.field private static final kGesturePan:I = 0x1

.field private static final kGestureRotate:I = 0x2

.field private static final kGestureSwipe:I = 0x5

.field private static final kGestureTwoFingerTap:I = 0x3

.field private static final kGestureUpdate:I = 0x1

.field private static final kGestureZoom:I

.field private static screenPPI:I


# instance fields
.field private mCheckForSwipe:Z

.field private mCouldBeTwoFingerTap:I

.field private mDidOccurTwoFingerGesture:Z

.field private mDownTouchPoints:[Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

.field private mInPanTransformGesture:Z

.field private mInRotateTransformGesture:Z

.field private mInZoomTransformGesture:Z

.field private mInZoomTransformGestureX:Z

.field private mInZoomTransformGestureY:Z

.field private mPreviousAbsoluteRotation:F

.field private mPreviousPanLocX:F

.field private mPreviousPanLocY:F

.field private mPreviousRotateLocX:F

.field private mPreviousRotateLocY:F

.field private mPreviousZoomLocX:F

.field private mPreviousZoomLocY:F

.field private mPrimaryPointOfTwoFingerTap:Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

.field private mSecondaryPointOfTwoFingerTap:Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

.field private mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

.field private mTwoFingerTapStartTime:J


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 60
    const/4 v0, 0x0

    sput v0, Lcom/adobe/air/gestures/AIRGestureListener;->screenPPI:I

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lcom/adobe/air/AIRWindowSurfaceView;)V
    .locals 7
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "aSurfaceView"    # Lcom/adobe/air/AIRWindowSurfaceView;

    .prologue
    const/4 v6, 0x0

    const/4 v5, 0x2

    const/4 v4, 0x0

    const/4 v1, 0x0

    .line 157
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 62
    iput v1, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousAbsoluteRotation:F

    .line 63
    iput-boolean v4, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInRotateTransformGesture:Z

    .line 64
    iput-boolean v4, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGesture:Z

    .line 65
    iput-boolean v4, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGestureX:Z

    .line 66
    iput-boolean v4, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGestureY:Z

    .line 67
    iput-boolean v4, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInPanTransformGesture:Z

    .line 69
    iput v1, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousRotateLocX:F

    .line 70
    iput v1, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousRotateLocY:F

    .line 71
    iput v1, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousZoomLocX:F

    .line 72
    iput v1, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousZoomLocY:F

    .line 73
    iput v1, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousPanLocX:F

    .line 74
    iput v1, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousPanLocY:F

    .line 76
    const-wide/16 v2, 0x0

    iput-wide v2, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mTwoFingerTapStartTime:J

    .line 77
    iput-boolean v4, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mDidOccurTwoFingerGesture:Z

    .line 89
    iput v4, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mCouldBeTwoFingerTap:I

    .line 90
    iput-object v6, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSecondaryPointOfTwoFingerTap:Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    .line 91
    iput-object v6, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPrimaryPointOfTwoFingerTap:Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    .line 92
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mCheckForSwipe:Z

    .line 158
    iput-object p2, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    .line 160
    new-array v1, v5, [Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    iput-object v1, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mDownTouchPoints:[Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    .line 161
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, v5, :cond_0

    .line 163
    iget-object v1, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mDownTouchPoints:[Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    new-instance v2, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    invoke-direct {v2, p0}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;-><init>(Lcom/adobe/air/gestures/AIRGestureListener;)V

    aput-object v2, v1, v0

    .line 161
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 166
    :cond_0
    new-instance v1, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    invoke-direct {v1, p0}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;-><init>(Lcom/adobe/air/gestures/AIRGestureListener;)V

    iput-object v1, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSecondaryPointOfTwoFingerTap:Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    .line 167
    invoke-static {p1}, Lcom/adobe/air/SystemCapabilities;->GetScreenDPI(Landroid/content/Context;)I

    move-result v1

    sput v1, Lcom/adobe/air/gestures/AIRGestureListener;->screenPPI:I

    .line 168
    return-void
.end method

.method private distanceBetweenPoints(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)D
    .locals 6
    .param p1, "pt1"    # Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;
    .param p2, "pt2"    # Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    .prologue
    const-wide/high16 v4, 0x4000000000000000L    # 2.0

    .line 924
    invoke-static {p2}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v0

    invoke-static {p1}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v1

    sub-float/2addr v0, v1

    float-to-double v0, v0

    invoke-static {v0, v1, v4, v5}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v0

    invoke-static {p2}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v2

    invoke-static {p1}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v3

    sub-float/2addr v2, v3

    float-to-double v2, v2

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v2

    add-double/2addr v0, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v0

    return-wide v0
.end method

.method private endPanGesture()V
    .locals 12

    .prologue
    .line 325
    iget-object v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v0}, Lcom/adobe/air/AIRWindowSurfaceView;->getMultitouchMode()I

    move-result v0

    iget-object v3, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    const/4 v3, 0x2

    if-eq v0, v3, :cond_1

    .line 347
    :cond_0
    :goto_0
    return-void

    .line 329
    :cond_1
    iget-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInPanTransformGesture:Z

    if-eqz v0, :cond_0

    .line 331
    const/4 v1, 0x4

    .line 332
    .local v1, "gesturePhase":I
    const/4 v2, 0x1

    .line 333
    .local v2, "gestureType":I
    const/4 v4, 0x0

    .line 334
    .local v4, "locX":F
    const/4 v5, 0x0

    .line 335
    .local v5, "locY":F
    const/high16 v6, 0x3f800000    # 1.0f

    .line 336
    .local v6, "scaleX":F
    const/high16 v7, 0x3f800000    # 1.0f

    .line 337
    .local v7, "scaleY":F
    const/4 v8, 0x0

    .line 338
    .local v8, "rotation":F
    const/4 v9, 0x0

    .line 339
    .local v9, "offsetX":F
    const/4 v10, 0x0

    .line 341
    .local v10, "offsetY":F
    iget v4, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousPanLocX:F

    .line 342
    iget v5, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousPanLocY:F

    .line 344
    const/4 v3, 0x1

    const/4 v11, 0x0

    move-object v0, p0

    invoke-direct/range {v0 .. v11}, Lcom/adobe/air/gestures/AIRGestureListener;->nativeOnGestureListener(IIZFFFFFFFF)Z

    .line 345
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInPanTransformGesture:Z

    goto :goto_0
.end method

.method private endRotateGesture()V
    .locals 12

    .prologue
    .line 271
    iget-object v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v0}, Lcom/adobe/air/AIRWindowSurfaceView;->getMultitouchMode()I

    move-result v0

    iget-object v3, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    const/4 v3, 0x2

    if-eq v0, v3, :cond_1

    .line 293
    :cond_0
    :goto_0
    return-void

    .line 275
    :cond_1
    iget-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInRotateTransformGesture:Z

    if-eqz v0, :cond_0

    .line 277
    const/4 v1, 0x4

    .line 278
    .local v1, "gesturePhase":I
    const/4 v2, 0x2

    .line 279
    .local v2, "gestureType":I
    const/4 v4, 0x0

    .line 280
    .local v4, "locX":F
    const/4 v5, 0x0

    .line 281
    .local v5, "locY":F
    const/high16 v6, 0x3f800000    # 1.0f

    .line 282
    .local v6, "scaleX":F
    const/high16 v7, 0x3f800000    # 1.0f

    .line 283
    .local v7, "scaleY":F
    const/4 v8, 0x0

    .line 284
    .local v8, "rotation":F
    const/4 v9, 0x0

    .line 285
    .local v9, "offsetX":F
    const/4 v10, 0x0

    .line 287
    .local v10, "offsetY":F
    iget v4, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousRotateLocX:F

    .line 288
    iget v5, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousRotateLocY:F

    .line 290
    const/4 v3, 0x1

    const/4 v11, 0x0

    move-object v0, p0

    invoke-direct/range {v0 .. v11}, Lcom/adobe/air/gestures/AIRGestureListener;->nativeOnGestureListener(IIZFFFFFFFF)Z

    .line 291
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInRotateTransformGesture:Z

    goto :goto_0
.end method

.method private endZoomGesture()V
    .locals 13

    .prologue
    const/4 v12, 0x0

    .line 297
    iget-object v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v0}, Lcom/adobe/air/AIRWindowSurfaceView;->getMultitouchMode()I

    move-result v0

    iget-object v3, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    const/4 v3, 0x2

    if-eq v0, v3, :cond_1

    .line 321
    :cond_0
    :goto_0
    return-void

    .line 301
    :cond_1
    iget-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGesture:Z

    if-eqz v0, :cond_0

    .line 303
    const/4 v1, 0x4

    .line 304
    .local v1, "gesturePhase":I
    const/4 v2, 0x0

    .line 305
    .local v2, "gestureType":I
    const/4 v4, 0x0

    .line 306
    .local v4, "locX":F
    const/4 v5, 0x0

    .line 307
    .local v5, "locY":F
    const/high16 v6, 0x3f800000    # 1.0f

    .line 308
    .local v6, "scaleX":F
    const/high16 v7, 0x3f800000    # 1.0f

    .line 309
    .local v7, "scaleY":F
    const/4 v8, 0x0

    .line 310
    .local v8, "rotation":F
    const/4 v9, 0x0

    .line 311
    .local v9, "offsetX":F
    const/4 v10, 0x0

    .line 313
    .local v10, "offsetY":F
    iget v4, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousZoomLocX:F

    .line 314
    iget v5, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousZoomLocY:F

    .line 316
    const/4 v3, 0x1

    const/4 v11, 0x0

    move-object v0, p0

    invoke-direct/range {v0 .. v11}, Lcom/adobe/air/gestures/AIRGestureListener;->nativeOnGestureListener(IIZFFFFFFFF)Z

    .line 317
    iput-boolean v12, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGesture:Z

    .line 318
    iput-boolean v12, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGestureX:Z

    .line 319
    iput-boolean v12, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGestureY:Z

    goto :goto_0
.end method

.method private getRotation(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F
    .locals 10
    .param p1, "initial_pt1"    # Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;
    .param p2, "initial_pt2"    # Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;
    .param p3, "current_pt1"    # Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;
    .param p4, "current_pt2"    # Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    .prologue
    .line 866
    const/4 v0, 0x0

    .line 867
    .local v0, "rotation":F
    invoke-static {p1}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$100(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)I

    move-result v1

    invoke-static {p3}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$100(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)I

    move-result v6

    if-ne v1, v6, :cond_0

    invoke-static {p2}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$100(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)I

    move-result v1

    invoke-static {p4}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$100(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)I

    move-result v6

    if-ne v1, v6, :cond_0

    .line 870
    invoke-static {p2}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v1

    invoke-static {p1}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v6

    sub-float/2addr v1, v6

    float-to-double v6, v1

    invoke-static {p2}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v1

    invoke-static {p1}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v8

    sub-float/2addr v1, v8

    float-to-double v8, v1

    invoke-static {v6, v7, v8, v9}, Ljava/lang/Math;->atan2(DD)D

    move-result-wide v6

    const-wide v8, 0x4066800000000000L    # 180.0

    mul-double/2addr v6, v8

    const-wide v8, 0x400921fb54442d18L    # Math.PI

    div-double v4, v6, v8

    .line 872
    .local v4, "theta_initial":D
    invoke-static {p4}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v1

    invoke-static {p3}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v6

    sub-float/2addr v1, v6

    float-to-double v6, v1

    invoke-static {p4}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v1

    invoke-static {p3}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v8

    sub-float/2addr v1, v8

    float-to-double v8, v1

    invoke-static {v6, v7, v8, v9}, Ljava/lang/Math;->atan2(DD)D

    move-result-wide v6

    const-wide v8, 0x4066800000000000L    # 180.0

    mul-double/2addr v6, v8

    const-wide v8, 0x400921fb54442d18L    # Math.PI

    div-double v2, v6, v8

    .line 874
    .local v2, "theta_current":D
    sub-double v6, v2, v4

    double-to-float v0, v6

    .line 877
    .end local v2    # "theta_current":D
    .end local v4    # "theta_initial":D
    :cond_0
    return v0
.end method

.method private isPanGesture(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)Z
    .locals 11
    .param p1, "initial_pt1"    # Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;
    .param p2, "initial_pt2"    # Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;
    .param p3, "current_pt1"    # Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;
    .param p4, "current_pt2"    # Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    .prologue
    const/4 v10, 0x0

    .line 891
    invoke-static {p3}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v8

    invoke-static {p1}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v9

    sub-float v2, v8, v9

    .line 892
    .local v2, "delta_pt1_x":F
    invoke-static {p3}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v8

    invoke-static {p1}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v9

    sub-float v3, v8, v9

    .line 894
    .local v3, "delta_pt1_y":F
    invoke-static {p4}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v8

    invoke-static {p2}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v9

    sub-float v4, v8, v9

    .line 895
    .local v4, "delta_pt2_x":F
    invoke-static {p4}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v8

    invoke-static {p2}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v9

    sub-float v5, v8, v9

    .line 897
    .local v5, "delta_pt2_y":F
    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v8

    invoke-static {v4}, Ljava/lang/Math;->abs(F)F

    move-result v9

    invoke-static {v8, v9}, Ljava/lang/Math;->min(FF)F

    move-result v6

    .line 898
    .local v6, "minTranslation_x":F
    invoke-static {v3}, Ljava/lang/Math;->abs(F)F

    move-result v8

    invoke-static {v5}, Ljava/lang/Math;->abs(F)F

    move-result v9

    invoke-static {v8, v9}, Ljava/lang/Math;->min(FF)F

    move-result v7

    .line 899
    .local v7, "minTranslation_y":F
    mul-float v8, v6, v6

    mul-float v9, v7, v7

    add-float/2addr v8, v9

    float-to-double v8, v8

    invoke-static {v8, v9}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v0

    .line 904
    .local v0, "absoluteTranslation":D
    cmpl-float v8, v2, v10

    if-ltz v8, :cond_0

    cmpl-float v8, v4, v10

    if-gez v8, :cond_1

    :cond_0
    cmpg-float v8, v2, v10

    if-gtz v8, :cond_5

    cmpg-float v8, v4, v10

    if-gtz v8, :cond_5

    :cond_1
    cmpl-float v8, v3, v10

    if-ltz v8, :cond_2

    cmpl-float v8, v5, v10

    if-gez v8, :cond_3

    :cond_2
    cmpg-float v8, v3, v10

    if-gtz v8, :cond_5

    cmpg-float v8, v5, v10

    if-gtz v8, :cond_5

    :cond_3
    iget-boolean v8, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInPanTransformGesture:Z

    if-nez v8, :cond_4

    const/high16 v8, 0x40400000    # 3.0f

    sget v9, Lcom/adobe/air/gestures/AIRGestureListener;->screenPPI:I

    int-to-float v9, v9

    mul-float/2addr v8, v9

    const v9, 0x41cb3333    # 25.4f

    div-float/2addr v8, v9

    float-to-double v8, v8

    cmpl-double v8, v0, v8

    if-lez v8, :cond_5

    .line 912
    :cond_4
    const/4 v8, 0x1

    .line 914
    :goto_0
    return v8

    :cond_5
    const/4 v8, 0x0

    goto :goto_0
.end method

.method private native nativeOnGestureListener(IIZFFFFFFFF)Z
.end method


# virtual methods
.method public endTwoFingerGesture()Z
    .locals 7

    .prologue
    const/4 v6, 0x1

    .line 245
    iget-object v2, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v2}, Lcom/adobe/air/AIRWindowSurfaceView;->getMultitouchMode()I

    move-result v2

    iget-object v3, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    const/4 v3, 0x2

    if-eq v2, v3, :cond_0

    .line 266
    :goto_0
    return v6

    .line 251
    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    .line 253
    .local v0, "currentTime":J
    iget-boolean v2, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mDidOccurTwoFingerGesture:Z

    if-nez v2, :cond_1

    iget v2, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mCouldBeTwoFingerTap:I

    const/4 v3, 0x3

    if-ne v2, v3, :cond_1

    iget-wide v2, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mTwoFingerTapStartTime:J

    sub-long v2, v0, v2

    .line 255
    invoke-static {}, Landroid/view/ViewConfiguration;->getTapTimeout()I

    move-result v4

    int-to-long v4, v4

    cmp-long v2, v2, v4

    if-gez v2, :cond_1

    .line 257
    invoke-virtual {p0}, Lcom/adobe/air/gestures/AIRGestureListener;->onTwoFingerTap()Z

    .line 264
    :cond_1
    invoke-direct {p0}, Lcom/adobe/air/gestures/AIRGestureListener;->endRotateGesture()V

    .line 265
    invoke-direct {p0}, Lcom/adobe/air/gestures/AIRGestureListener;->endPanGesture()V

    goto :goto_0
.end method

.method public getCheckForSwipe()Z
    .locals 1

    .prologue
    .line 235
    iget-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mCheckForSwipe:Z

    return v0
.end method

.method public getCouldBeTwoFingerTap()I
    .locals 1

    .prologue
    .line 211
    iget v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mCouldBeTwoFingerTap:I

    return v0
.end method

.method public getDownTouchPoint(I)Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;
    .locals 1
    .param p1, "pid"    # I

    .prologue
    .line 177
    if-ltz p1, :cond_0

    const/4 v0, 0x2

    if-ge p1, v0, :cond_0

    .line 178
    iget-object v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mDownTouchPoints:[Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    aget-object v0, v0, p1

    .line 180
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public mayStartNewTransformGesture()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 226
    iput-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInRotateTransformGesture:Z

    .line 227
    iput-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGesture:Z

    .line 228
    iput-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGestureX:Z

    .line 229
    iput-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGestureY:Z

    .line 230
    iput-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInPanTransformGesture:Z

    .line 231
    return-void
.end method

.method public onDoubleTap(Landroid/view/MotionEvent;)Z
    .locals 6
    .param p1, "me"    # Landroid/view/MotionEvent;

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 696
    const/4 v0, 0x1

    .line 700
    .local v0, "retVal":Z
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v3

    if-ne v3, v1, :cond_0

    .line 702
    if-eqz v0, :cond_1

    iget-object v3, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {p1, v2}, Landroid/view/MotionEvent;->getX(I)F

    move-result v4

    invoke-virtual {p1, v2}, Landroid/view/MotionEvent;->getY(I)F

    move-result v5

    invoke-virtual {v3, v4, v5}, Lcom/adobe/air/AIRWindowSurfaceView;->nativeOnDoubleClickListener(FF)Z

    move-result v3

    if-eqz v3, :cond_1

    move v0, v1

    .line 704
    :cond_0
    :goto_0
    return v0

    :cond_1
    move v0, v2

    .line 702
    goto :goto_0
.end method

.method public onDoubleTapEvent(Landroid/view/MotionEvent;)Z
    .locals 1
    .param p1, "e"    # Landroid/view/MotionEvent;

    .prologue
    .line 712
    const/4 v0, 0x1

    return v0
.end method

.method public onDown(Landroid/view/MotionEvent;)Z
    .locals 1
    .param p1, "e"    # Landroid/view/MotionEvent;

    .prologue
    .line 357
    const/4 v0, 0x1

    return v0
.end method

.method public onFling(Landroid/view/MotionEvent;Landroid/view/MotionEvent;FF)Z
    .locals 1
    .param p1, "e1"    # Landroid/view/MotionEvent;
    .param p2, "e2"    # Landroid/view/MotionEvent;
    .param p3, "velocityX"    # F
    .param p4, "velocityY"    # F

    .prologue
    .line 365
    const/4 v0, 0x1

    return v0
.end method

.method public onLongPress(Landroid/view/MotionEvent;)V
    .locals 0
    .param p1, "e"    # Landroid/view/MotionEvent;

    .prologue
    .line 373
    return-void
.end method

.method public onScale(Landroid/view/ScaleGestureDetector;)Z
    .locals 30
    .param p1, "detector"    # Landroid/view/ScaleGestureDetector;

    .prologue
    .line 743
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v2}, Lcom/adobe/air/AIRWindowSurfaceView;->getMultitouchMode()I

    move-result v2

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v5}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    const/4 v5, 0x2

    if-eq v2, v5, :cond_0

    .line 744
    const/4 v2, 0x1

    .line 826
    :goto_0
    return v2

    .line 748
    :cond_0
    const/4 v3, 0x1

    .line 749
    .local v3, "gesturePhase":I
    const/4 v4, 0x0

    .line 751
    .local v4, "gestureType":I
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getFocusX()F

    move-result v6

    .line 752
    .local v6, "locX":F
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getFocusY()F

    move-result v7

    .line 754
    .local v7, "locY":F
    const/high16 v8, 0x3f800000    # 1.0f

    .line 755
    .local v8, "scaleX":F
    const/high16 v9, 0x3f800000    # 1.0f

    .line 756
    .local v9, "scaleY":F
    const/4 v10, 0x0

    .line 757
    .local v10, "rotation":F
    const/4 v11, 0x0

    .line 758
    .local v11, "offsetX":F
    const/4 v12, 0x0

    .line 760
    .local v12, "offsetY":F
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getPreviousSpan()F

    move-result v2

    float-to-double v0, v2

    move-wide/from16 v22, v0

    .line 761
    .local v22, "initialDistance":D
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getCurrentSpan()F

    move-result v2

    float-to-double v14, v2

    .line 762
    .local v14, "currentDistance":D
    sub-double v26, v14, v22

    invoke-static/range {v26 .. v27}, Ljava/lang/Math;->abs(D)D

    move-result-wide v16

    .line 763
    .local v16, "deltaDistance":D
    const-wide/16 v18, 0x0

    .line 764
    .local v18, "deltaDistanceX":D
    const-wide/16 v20, 0x0

    .line 765
    .local v20, "deltaDistanceY":D
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v5, 0xb

    if-lt v2, v5, :cond_1

    .line 767
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getCurrentSpanX()F

    move-result v2

    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getPreviousSpanX()F

    move-result v5

    sub-float/2addr v2, v5

    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v2

    float-to-double v0, v2

    move-wide/from16 v18, v0

    .line 768
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getCurrentSpanY()F

    move-result v2

    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getPreviousSpanY()F

    move-result v5

    sub-float/2addr v2, v5

    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v2

    float-to-double v0, v2

    move-wide/from16 v20, v0

    .line 771
    :cond_1
    const-wide/16 v26, 0x0

    cmpl-double v2, v22, v26

    if-eqz v2, :cond_a

    .line 773
    move-object/from16 v0, p0

    iget-boolean v2, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGesture:Z

    if-nez v2, :cond_2

    const-wide v26, 0x4039666660000000L    # 25.399999618530273

    mul-double v26, v26, v16

    sget v2, Lcom/adobe/air/gestures/AIRGestureListener;->screenPPI:I

    int-to-double v0, v2

    move-wide/from16 v28, v0

    div-double v26, v26, v28

    const-wide/high16 v28, 0x4020000000000000L    # 8.0

    cmpl-double v2, v26, v28

    if-lez v2, :cond_9

    .line 775
    :cond_2
    move-object/from16 v0, p0

    iget-boolean v2, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGesture:Z

    if-nez v2, :cond_3

    .line 777
    const/4 v2, 0x1

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGesture:Z

    .line 778
    const/4 v3, 0x2

    .line 779
    const/4 v2, 0x1

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mDidOccurTwoFingerGesture:Z

    .line 784
    :cond_3
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v5, 0xb

    if-lt v2, v5, :cond_8

    .line 786
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getPreviousSpanX()F

    move-result v2

    const/4 v5, 0x0

    cmpl-float v2, v2, v5

    if-eqz v2, :cond_5

    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getCurrentSpanX()F

    move-result v2

    const/4 v5, 0x0

    cmpl-float v2, v2, v5

    if-eqz v2, :cond_5

    move-object/from16 v0, p0

    iget-boolean v2, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGestureX:Z

    if-nez v2, :cond_4

    const-wide v26, 0x4039666660000000L    # 25.399999618530273

    mul-double v26, v26, v18

    sget v2, Lcom/adobe/air/gestures/AIRGestureListener;->screenPPI:I

    int-to-double v0, v2

    move-wide/from16 v28, v0

    div-double v26, v26, v28

    const-wide/high16 v28, 0x4008000000000000L    # 3.0

    cmpl-double v2, v26, v28

    if-lez v2, :cond_5

    .line 789
    :cond_4
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getCurrentSpanX()F

    move-result v2

    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getPreviousSpanX()F

    move-result v5

    div-float/2addr v2, v5

    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v8

    .line 790
    const/4 v2, 0x1

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGestureX:Z

    .line 793
    :cond_5
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getPreviousSpanY()F

    move-result v2

    const/4 v5, 0x0

    cmpl-float v2, v2, v5

    if-eqz v2, :cond_7

    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getCurrentSpanY()F

    move-result v2

    const/4 v5, 0x0

    cmpl-float v2, v2, v5

    if-eqz v2, :cond_7

    move-object/from16 v0, p0

    iget-boolean v2, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGestureY:Z

    if-nez v2, :cond_6

    const-wide v26, 0x4039666660000000L    # 25.399999618530273

    mul-double v26, v26, v20

    sget v2, Lcom/adobe/air/gestures/AIRGestureListener;->screenPPI:I

    int-to-double v0, v2

    move-wide/from16 v28, v0

    div-double v26, v26, v28

    const-wide/high16 v28, 0x4008000000000000L    # 3.0

    cmpl-double v2, v26, v28

    if-lez v2, :cond_7

    .line 796
    :cond_6
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getCurrentSpanY()F

    move-result v2

    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getPreviousSpanY()F

    move-result v5

    div-float/2addr v2, v5

    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v9

    .line 797
    const/4 v2, 0x1

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGestureY:Z

    .line 812
    :cond_7
    :goto_1
    move-object/from16 v0, p0

    iput v6, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousZoomLocX:F

    .line 813
    move-object/from16 v0, p0

    iput v7, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousZoomLocY:F

    .line 816
    const/4 v5, 0x1

    const/4 v13, 0x0

    move-object/from16 v2, p0

    invoke-direct/range {v2 .. v13}, Lcom/adobe/air/gestures/AIRGestureListener;->nativeOnGestureListener(IIZFFFFFFFF)Z

    .line 818
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 802
    :cond_8
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getScaleFactor()F

    move-result v24

    .line 805
    .local v24, "scaleFactor":F
    move/from16 v8, v24

    .line 806
    move/from16 v9, v24

    goto :goto_1

    .line 823
    .end local v24    # "scaleFactor":F
    :cond_9
    const/4 v2, 0x0

    goto/16 :goto_0

    .line 826
    :cond_a
    const/4 v2, 0x0

    goto/16 :goto_0
.end method

.method public onScaleBegin(Landroid/view/ScaleGestureDetector;)Z
    .locals 1
    .param p1, "detector"    # Landroid/view/ScaleGestureDetector;

    .prologue
    .line 724
    iget-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGesture:Z

    if-eqz v0, :cond_0

    .line 727
    invoke-direct {p0}, Lcom/adobe/air/gestures/AIRGestureListener;->endZoomGesture()V

    .line 733
    :cond_0
    const/4 v0, 0x1

    return v0
.end method

.method public onScaleEnd(Landroid/view/ScaleGestureDetector;)V
    .locals 12
    .param p1, "detector"    # Landroid/view/ScaleGestureDetector;

    .prologue
    const/4 v8, 0x0

    .line 836
    iget-object v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v0}, Lcom/adobe/air/AIRWindowSurfaceView;->getMultitouchMode()I

    move-result v0

    iget-object v1, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    const/4 v1, 0x2

    if-eq v0, v1, :cond_1

    .line 853
    :cond_0
    :goto_0
    return-void

    .line 843
    :cond_1
    iget-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGesture:Z

    if-eqz v0, :cond_0

    .line 845
    invoke-virtual {p1}, Landroid/view/ScaleGestureDetector;->getScaleFactor()F

    move-result v6

    .line 851
    .local v6, "scaleFactor":F
    const/4 v1, 0x4

    const/4 v2, 0x0

    const/4 v3, 0x1

    iget v4, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousZoomLocX:F

    iget v5, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousZoomLocY:F

    move-object v0, p0

    move v7, v6

    move v9, v8

    move v10, v8

    move v11, v8

    invoke-direct/range {v0 .. v11}, Lcom/adobe/air/gestures/AIRGestureListener;->nativeOnGestureListener(IIZFFFFFFFF)Z

    goto :goto_0
.end method

.method public onScroll(Landroid/view/MotionEvent;Landroid/view/MotionEvent;FF)Z
    .locals 30
    .param p1, "e1"    # Landroid/view/MotionEvent;
    .param p2, "e2"    # Landroid/view/MotionEvent;
    .param p3, "distanceX"    # F
    .param p4, "distanceY"    # F

    .prologue
    .line 381
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v4}, Lcom/adobe/air/AIRWindowSurfaceView;->getMultitouchMode()I

    move-result v4

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v7}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    const/4 v7, 0x2

    if-eq v4, v7, :cond_0

    .line 382
    const/4 v4, 0x1

    .line 629
    :goto_0
    return v4

    .line 389
    :cond_0
    const/4 v5, 0x2

    .line 390
    .local v5, "gesturePhase":I
    const/4 v6, 0x2

    .line 391
    .local v6, "gestureType":I
    const/4 v8, 0x0

    .line 392
    .local v8, "locX":F
    const/4 v9, 0x0

    .line 393
    .local v9, "locY":F
    const/high16 v10, 0x3f800000    # 1.0f

    .line 394
    .local v10, "scaleX":F
    const/high16 v11, 0x3f800000    # 1.0f

    .line 395
    .local v11, "scaleY":F
    const/4 v12, 0x0

    .line 396
    .local v12, "rotation":F
    const/4 v13, 0x0

    .line 397
    .local v13, "offsetX":F
    const/4 v14, 0x0

    .line 403
    .local v14, "offsetY":F
    invoke-virtual/range {p2 .. p2}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v4

    const/4 v7, 0x2

    if-ne v4, v7, :cond_c

    .line 408
    const/4 v5, 0x1

    .line 410
    const/4 v4, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/view/MotionEvent;->getX(I)F

    move-result v4

    const/4 v7, 0x1

    move-object/from16 v0, p2

    invoke-virtual {v0, v7}, Landroid/view/MotionEvent;->getX(I)F

    move-result v7

    add-float/2addr v4, v7

    const/high16 v7, 0x40000000    # 2.0f

    div-float v8, v4, v7

    .line 411
    const/4 v4, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/view/MotionEvent;->getY(I)F

    move-result v4

    const/4 v7, 0x1

    move-object/from16 v0, p2

    invoke-virtual {v0, v7}, Landroid/view/MotionEvent;->getY(I)F

    move-result v7

    add-float/2addr v4, v7

    const/high16 v7, 0x40000000    # 2.0f

    div-float v9, v4, v7

    .line 416
    const/4 v4, 0x2

    new-array v0, v4, [Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    move-object/from16 v17, v0

    .line 418
    .local v17, "currentTouchPoint":[Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;
    const/16 v20, 0x0

    .local v20, "i":I
    :goto_1
    const/4 v4, 0x2

    move/from16 v0, v20

    if-ge v0, v4, :cond_1

    .line 420
    new-instance v4, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    move-object/from16 v0, p2

    move/from16 v1, v20

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getX(I)F

    move-result v7

    move-object/from16 v0, p2

    move/from16 v1, v20

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getY(I)F

    move-result v25

    move-object/from16 v0, p2

    move/from16 v1, v20

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v26

    move-object/from16 v0, p0

    move/from16 v1, v25

    move/from16 v2, v26

    invoke-direct {v4, v0, v7, v1, v2}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;-><init>(Lcom/adobe/air/gestures/AIRGestureListener;FFI)V

    aput-object v4, v17, v20

    .line 418
    add-int/lit8 v20, v20, 0x1

    goto :goto_1

    .line 423
    :cond_1
    const/4 v4, 0x0

    aget-object v4, v17, v4

    invoke-static {v4}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$100(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)I

    move-result v22

    .line 424
    .local v22, "pid1":I
    const/4 v4, 0x1

    aget-object v4, v17, v4

    invoke-static {v4}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$100(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)I

    move-result v23

    .line 426
    .local v23, "pid2":I
    if-ltz v22, :cond_8

    const/4 v4, 0x2

    move/from16 v0, v22

    if-ge v0, v4, :cond_8

    if-ltz v23, :cond_8

    const/4 v4, 0x2

    move/from16 v0, v23

    if-ge v0, v4, :cond_8

    .line 432
    move-object/from16 v0, p0

    iget-boolean v4, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mInPanTransformGesture:Z

    if-nez v4, :cond_6

    .line 441
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mDownTouchPoints:[Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    aget-object v4, v4, v22

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mDownTouchPoints:[Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    aget-object v7, v7, v23

    const/16 v25, 0x0

    aget-object v25, v17, v25

    const/16 v26, 0x1

    aget-object v26, v17, v26

    move-object/from16 v0, p0

    move-object/from16 v1, v25

    move-object/from16 v2, v26

    invoke-direct {v0, v4, v7, v1, v2}, Lcom/adobe/air/gestures/AIRGestureListener;->getRotation(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v16

    .line 446
    .local v16, "absoluteRotation":F
    invoke-static/range {v16 .. v16}, Ljava/lang/Math;->abs(F)F

    move-result v4

    const/high16 v7, 0x43340000    # 180.0f

    cmpl-float v4, v4, v7

    if-lez v4, :cond_2

    .line 448
    const/4 v4, 0x0

    cmpl-float v4, v16, v4

    if-lez v4, :cond_9

    const/high16 v4, 0x43b40000    # 360.0f

    sub-float v4, v4, v16

    const/high16 v7, -0x40800000    # -1.0f

    mul-float v16, v4, v7

    .line 454
    :cond_2
    :goto_2
    move-object/from16 v0, p0

    iget-boolean v4, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mInRotateTransformGesture:Z

    if-nez v4, :cond_3

    invoke-static/range {v16 .. v16}, Ljava/lang/Math;->abs(F)F

    move-result v4

    const/high16 v7, 0x41700000    # 15.0f

    cmpl-float v4, v4, v7

    if-lez v4, :cond_6

    .line 456
    :cond_3
    const/4 v6, 0x2

    .line 457
    move-object/from16 v0, p0

    iget-boolean v4, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mInRotateTransformGesture:Z

    if-nez v4, :cond_4

    .line 459
    const/4 v5, 0x2

    .line 460
    const/4 v4, 0x1

    move-object/from16 v0, p0

    iput-boolean v4, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mInRotateTransformGesture:Z

    .line 461
    const/4 v4, 0x0

    move-object/from16 v0, p0

    iput v4, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousAbsoluteRotation:F

    .line 462
    const/4 v4, 0x1

    move-object/from16 v0, p0

    iput-boolean v4, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mDidOccurTwoFingerGesture:Z

    .line 465
    :cond_4
    move-object/from16 v0, p0

    iget v4, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousAbsoluteRotation:F

    sub-float v12, v16, v4

    .line 470
    invoke-static {v12}, Ljava/lang/Math;->abs(F)F

    move-result v4

    const/high16 v7, 0x43340000    # 180.0f

    cmpl-float v4, v4, v7

    if-lez v4, :cond_5

    .line 472
    const/4 v4, 0x0

    cmpl-float v4, v12, v4

    if-lez v4, :cond_a

    const/high16 v4, 0x43b40000    # 360.0f

    sub-float/2addr v4, v12

    const/high16 v7, -0x40800000    # -1.0f

    mul-float v12, v4, v7

    .line 477
    :cond_5
    :goto_3
    move/from16 v0, v16

    move-object/from16 v1, p0

    iput v0, v1, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousAbsoluteRotation:F

    .line 478
    move-object/from16 v0, p0

    iput v8, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousRotateLocX:F

    .line 479
    move-object/from16 v0, p0

    iput v9, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousRotateLocY:F

    .line 482
    const/4 v7, 0x1

    const/4 v15, 0x0

    move-object/from16 v4, p0

    invoke-direct/range {v4 .. v15}, Lcom/adobe/air/gestures/AIRGestureListener;->nativeOnGestureListener(IIZFFFFFFFF)Z

    .line 485
    const/4 v12, 0x0

    .line 493
    .end local v16    # "absoluteRotation":F
    :cond_6
    move-object/from16 v0, p0

    iget-boolean v4, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGesture:Z

    if-nez v4, :cond_8

    move-object/from16 v0, p0

    iget-boolean v4, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mInRotateTransformGesture:Z

    if-nez v4, :cond_8

    .line 496
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mDownTouchPoints:[Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    aget-object v4, v4, v22

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mDownTouchPoints:[Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    aget-object v7, v7, v23

    const/16 v25, 0x0

    aget-object v25, v17, v25

    const/16 v26, 0x1

    aget-object v26, v17, v26

    move-object/from16 v0, p0

    move-object/from16 v1, v25

    move-object/from16 v2, v26

    invoke-direct {v0, v4, v7, v1, v2}, Lcom/adobe/air/gestures/AIRGestureListener;->isPanGesture(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)Z

    move-result v4

    if-eqz v4, :cond_b

    .line 501
    const/4 v6, 0x1

    .line 502
    move-object/from16 v0, p0

    iget-boolean v4, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mInPanTransformGesture:Z

    if-nez v4, :cond_7

    .line 504
    const/4 v5, 0x2

    .line 505
    const/4 v4, 0x1

    move-object/from16 v0, p0

    iput-boolean v4, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mInPanTransformGesture:Z

    .line 506
    const/4 v4, 0x1

    move-object/from16 v0, p0

    iput-boolean v4, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mDidOccurTwoFingerGesture:Z

    .line 509
    :cond_7
    const/high16 v4, -0x40800000    # -1.0f

    mul-float v13, v4, p3

    .line 510
    const/high16 v4, -0x40800000    # -1.0f

    mul-float v14, v4, p4

    .line 511
    move-object/from16 v0, p0

    iput v8, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousPanLocX:F

    .line 512
    move-object/from16 v0, p0

    iput v9, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousPanLocY:F

    .line 517
    const/4 v7, 0x1

    const/4 v15, 0x0

    move-object/from16 v4, p0

    invoke-direct/range {v4 .. v15}, Lcom/adobe/air/gestures/AIRGestureListener;->nativeOnGestureListener(IIZFFFFFFFF)Z

    .line 520
    const/4 v13, 0x0

    .line 521
    const/4 v14, 0x0

    .line 629
    .end local v17    # "currentTouchPoint":[Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;
    .end local v20    # "i":I
    .end local v22    # "pid1":I
    .end local v23    # "pid2":I
    :cond_8
    :goto_4
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 448
    .restart local v16    # "absoluteRotation":F
    .restart local v17    # "currentTouchPoint":[Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;
    .restart local v20    # "i":I
    .restart local v22    # "pid1":I
    .restart local v23    # "pid2":I
    :cond_9
    const/high16 v4, 0x43b40000    # 360.0f

    add-float v16, v16, v4

    goto/16 :goto_2

    .line 472
    :cond_a
    const/high16 v4, 0x43b40000    # 360.0f

    add-float/2addr v12, v4

    goto :goto_3

    .line 525
    .end local v16    # "absoluteRotation":F
    :cond_b
    move-object/from16 v0, p0

    iget-boolean v4, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mInPanTransformGesture:Z

    if-eqz v4, :cond_8

    .line 528
    invoke-direct/range {p0 .. p0}, Lcom/adobe/air/gestures/AIRGestureListener;->endPanGesture()V

    .line 529
    const/4 v4, 0x0

    aget-object v4, v17, v4

    invoke-static {v4}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v4

    const/4 v7, 0x0

    aget-object v7, v17, v7

    invoke-static {v7}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v7

    const/16 v25, 0x0

    aget-object v25, v17, v25

    invoke-static/range {v25 .. v25}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$100(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)I

    move-result v25

    move-object/from16 v0, p0

    move/from16 v1, v25

    invoke-virtual {v0, v4, v7, v1}, Lcom/adobe/air/gestures/AIRGestureListener;->setDownTouchPoint(FFI)V

    .line 530
    const/4 v4, 0x1

    aget-object v4, v17, v4

    invoke-static {v4}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v4

    const/4 v7, 0x1

    aget-object v7, v17, v7

    invoke-static {v7}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v7

    const/16 v25, 0x1

    aget-object v25, v17, v25

    invoke-static/range {v25 .. v25}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$100(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)I

    move-result v25

    move-object/from16 v0, p0

    move/from16 v1, v25

    invoke-virtual {v0, v4, v7, v1}, Lcom/adobe/air/gestures/AIRGestureListener;->setDownTouchPoint(FFI)V

    goto :goto_4

    .line 540
    .end local v17    # "currentTouchPoint":[Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;
    .end local v20    # "i":I
    .end local v22    # "pid1":I
    .end local v23    # "pid2":I
    :cond_c
    invoke-virtual/range {p2 .. p2}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v4

    const/4 v7, 0x1

    if-ne v4, v7, :cond_8

    .line 542
    const/4 v4, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v24

    .line 544
    .local v24, "pid_swipe":I
    if-ltz v24, :cond_8

    const/4 v4, 0x2

    move/from16 v0, v24

    if-ge v0, v4, :cond_8

    .line 552
    move-object/from16 v0, p0

    iget-boolean v4, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mCheckForSwipe:Z

    if-eqz v4, :cond_8

    .line 554
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v4

    const/4 v7, 0x1

    if-ne v4, v7, :cond_8

    .line 556
    const/16 v21, 0x0

    .line 557
    .local v21, "isSwipe":Z
    const/16 v18, 0x0

    .line 558
    .local v18, "delta_x":F
    const/16 v19, 0x0

    .line 559
    .local v19, "delta_y":F
    const/4 v15, 0x0

    .line 561
    .local v15, "velocity":F
    const/4 v4, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/view/MotionEvent;->getX(I)F

    move-result v4

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mDownTouchPoints:[Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    aget-object v7, v7, v24

    invoke-static {v7}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v7

    sub-float v18, v4, v7

    .line 562
    const/4 v4, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/view/MotionEvent;->getY(I)F

    move-result v4

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mDownTouchPoints:[Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    aget-object v7, v7, v24

    invoke-static {v7}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v7

    sub-float v19, v4, v7

    .line 566
    invoke-static/range {v18 .. v18}, Ljava/lang/Math;->abs(F)F

    move-result v4

    const v7, 0x41cb3333    # 25.4f

    mul-float/2addr v4, v7

    sget v7, Lcom/adobe/air/gestures/AIRGestureListener;->screenPPI:I

    int-to-float v7, v7

    div-float/2addr v4, v7

    const/high16 v7, 0x41200000    # 10.0f

    cmpl-float v4, v4, v7

    if-ltz v4, :cond_f

    invoke-static/range {v19 .. v19}, Ljava/lang/Math;->abs(F)F

    move-result v4

    const v7, 0x41cb3333    # 25.4f

    mul-float/2addr v4, v7

    sget v7, Lcom/adobe/air/gestures/AIRGestureListener;->screenPPI:I

    int-to-float v7, v7

    div-float/2addr v4, v7

    const/high16 v7, 0x40a00000    # 5.0f

    cmpg-float v4, v4, v7

    if-gtz v4, :cond_f

    .line 568
    const/16 v21, 0x1

    .line 569
    const/4 v4, 0x0

    cmpl-float v4, v18, v4

    if-lez v4, :cond_e

    const/high16 v13, 0x3f800000    # 1.0f

    .line 570
    :goto_5
    const/4 v14, 0x0

    .line 571
    const/4 v4, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/view/MotionEvent;->getX(I)F

    move-result v4

    const/4 v7, 0x0

    move-object/from16 v0, p1

    invoke-virtual {v0, v7}, Landroid/view/MotionEvent;->getX(I)F

    move-result v7

    sub-float/2addr v4, v7

    invoke-virtual/range {p2 .. p2}, Landroid/view/MotionEvent;->getEventTime()J

    move-result-wide v26

    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getEventTime()J

    move-result-wide v28

    sub-long v26, v26, v28

    move-wide/from16 v0, v26

    long-to-float v7, v0

    div-float/2addr v4, v7

    const/high16 v7, 0x447a0000    # 1000.0f

    mul-float v15, v4, v7

    .line 586
    :goto_6
    if-eqz v21, :cond_8

    .line 590
    const/16 v5, 0x8

    .line 591
    const/4 v6, 0x5

    .line 594
    const/4 v4, 0x0

    move-object/from16 v0, p1

    invoke-virtual {v0, v4}, Landroid/view/MotionEvent;->getX(I)F

    move-result v8

    .line 595
    const/4 v4, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/view/MotionEvent;->getY(I)F

    move-result v9

    .line 597
    const/4 v4, 0x0

    cmpg-float v4, v15, v4

    if-gez v4, :cond_d

    .line 598
    const/high16 v4, -0x40800000    # -1.0f

    mul-float/2addr v15, v4

    .line 601
    :cond_d
    const/4 v7, 0x1

    move-object/from16 v4, p0

    invoke-direct/range {v4 .. v15}, Lcom/adobe/air/gestures/AIRGestureListener;->nativeOnGestureListener(IIZFFFFFFFF)Z

    .line 603
    const/4 v4, 0x0

    move-object/from16 v0, p0

    iput-boolean v4, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mCheckForSwipe:Z

    goto/16 :goto_4

    .line 569
    :cond_e
    const/high16 v13, -0x40800000    # -1.0f

    goto :goto_5

    .line 573
    :cond_f
    invoke-static/range {v19 .. v19}, Ljava/lang/Math;->abs(F)F

    move-result v4

    const v7, 0x41cb3333    # 25.4f

    mul-float/2addr v4, v7

    sget v7, Lcom/adobe/air/gestures/AIRGestureListener;->screenPPI:I

    int-to-float v7, v7

    div-float/2addr v4, v7

    const/high16 v7, 0x41200000    # 10.0f

    cmpl-float v4, v4, v7

    if-ltz v4, :cond_11

    invoke-static/range {v18 .. v18}, Ljava/lang/Math;->abs(F)F

    move-result v4

    const v7, 0x41cb3333    # 25.4f

    mul-float/2addr v4, v7

    sget v7, Lcom/adobe/air/gestures/AIRGestureListener;->screenPPI:I

    int-to-float v7, v7

    div-float/2addr v4, v7

    const/high16 v7, 0x40a00000    # 5.0f

    cmpg-float v4, v4, v7

    if-gtz v4, :cond_11

    .line 575
    const/16 v21, 0x1

    .line 576
    const/4 v13, 0x0

    .line 577
    const/4 v4, 0x0

    cmpl-float v4, v19, v4

    if-lez v4, :cond_10

    const/high16 v14, 0x3f800000    # 1.0f

    .line 578
    :goto_7
    const/4 v4, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v4}, Landroid/view/MotionEvent;->getY(I)F

    move-result v4

    const/4 v7, 0x0

    move-object/from16 v0, p1

    invoke-virtual {v0, v7}, Landroid/view/MotionEvent;->getY(I)F

    move-result v7

    sub-float/2addr v4, v7

    invoke-virtual/range {p2 .. p2}, Landroid/view/MotionEvent;->getEventTime()J

    move-result-wide v26

    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getEventTime()J

    move-result-wide v28

    sub-long v26, v26, v28

    move-wide/from16 v0, v26

    long-to-float v7, v0

    div-float/2addr v4, v7

    const/high16 v7, 0x447a0000    # 1000.0f

    mul-float v15, v4, v7

    goto :goto_6

    .line 577
    :cond_10
    const/high16 v14, -0x40800000    # -1.0f

    goto :goto_7

    .line 583
    :cond_11
    const/16 v21, 0x0

    goto :goto_6
.end method

.method public onShowPress(Landroid/view/MotionEvent;)V
    .locals 0
    .param p1, "e"    # Landroid/view/MotionEvent;

    .prologue
    .line 637
    return-void
.end method

.method public onSingleTapConfirmed(Landroid/view/MotionEvent;)Z
    .locals 1
    .param p1, "me"    # Landroid/view/MotionEvent;

    .prologue
    .line 678
    const/4 v0, 0x1

    return v0
.end method

.method public onSingleTapUp(Landroid/view/MotionEvent;)Z
    .locals 1
    .param p1, "e"    # Landroid/view/MotionEvent;

    .prologue
    .line 686
    const/4 v0, 0x1

    return v0
.end method

.method public onTwoFingerTap()Z
    .locals 14

    .prologue
    const/high16 v9, 0x40000000    # 2.0f

    const/high16 v6, 0x3f800000    # 1.0f

    const/4 v3, 0x0

    const/4 v8, 0x0

    .line 650
    const/4 v12, 0x1

    .line 652
    .local v12, "retVal":Z
    iget-object v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v0}, Lcom/adobe/air/AIRWindowSurfaceView;->getMultitouchMode()I

    move-result v0

    iget-object v7, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v7}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    const/4 v7, 0x2

    if-eq v0, v7, :cond_0

    move v13, v12

    .line 670
    .end local v12    # "retVal":Z
    .local v13, "retVal":I
    :goto_0
    return v13

    .line 655
    .end local v13    # "retVal":I
    .restart local v12    # "retVal":Z
    :cond_0
    const/16 v1, 0x8

    .line 656
    .local v1, "gesturePhase":I
    const/4 v2, 0x3

    .line 657
    .local v2, "gestureType":I
    const/4 v4, 0x0

    .line 658
    .local v4, "locX":F
    const/4 v5, 0x0

    .line 661
    .local v5, "locY":F
    iget-object v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSecondaryPointOfTwoFingerTap:Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    invoke-static {v0}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v0

    iget-object v7, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPrimaryPointOfTwoFingerTap:Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    invoke-static {v7}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v7

    add-float/2addr v0, v7

    div-float v4, v0, v9

    .line 662
    iget-object v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSecondaryPointOfTwoFingerTap:Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    invoke-static {v0}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v0

    iget-object v7, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPrimaryPointOfTwoFingerTap:Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    invoke-static {v7}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v7

    add-float/2addr v0, v7

    div-float v5, v0, v9

    .line 665
    if-eqz v12, :cond_1

    move-object v0, p0

    move v7, v6

    move v9, v8

    move v10, v8

    move v11, v8

    invoke-direct/range {v0 .. v11}, Lcom/adobe/air/gestures/AIRGestureListener;->nativeOnGestureListener(IIZFFFFFFFF)Z

    move-result v0

    if-eqz v0, :cond_1

    const/4 v12, 0x1

    .line 668
    :goto_1
    iput v3, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mCouldBeTwoFingerTap:I

    move v13, v12

    .line 670
    .restart local v13    # "retVal":I
    goto :goto_0

    .end local v13    # "retVal":I
    :cond_1
    move v12, v3

    .line 665
    goto :goto_1
.end method

.method public setCheckForSwipe(Z)V
    .locals 0
    .param p1, "aVal"    # Z

    .prologue
    .line 240
    iput-boolean p1, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mCheckForSwipe:Z

    .line 241
    return-void
.end method

.method public setCouldBeTwoFingerTap(I)V
    .locals 2
    .param p1, "iVal"    # I

    .prologue
    .line 200
    iput p1, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mCouldBeTwoFingerTap:I

    .line 202
    if-nez p1, :cond_0

    .line 203
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mTwoFingerTapStartTime:J

    .line 204
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mDidOccurTwoFingerGesture:Z

    .line 207
    :cond_0
    return-void
.end method

.method public setDownTouchPoint(FFI)V
    .locals 1
    .param p1, "x"    # F
    .param p2, "y"    # F
    .param p3, "pid"    # I

    .prologue
    .line 192
    if-ltz p3, :cond_0

    const/4 v0, 0x2

    if-ge p3, v0, :cond_0

    .line 194
    iget-object v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mDownTouchPoints:[Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    aget-object v0, v0, p3

    invoke-static {v0, p1, p2, p3}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$000(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;FFI)V

    .line 196
    :cond_0
    return-void
.end method

.method public setPrimaryPointOfTwoFingerTap(FFI)V
    .locals 1
    .param p1, "x"    # F
    .param p2, "y"    # F
    .param p3, "pid"    # I

    .prologue
    .line 221
    new-instance v0, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;-><init>(Lcom/adobe/air/gestures/AIRGestureListener;FFI)V

    iput-object v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPrimaryPointOfTwoFingerTap:Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    .line 222
    return-void
.end method

.method public setSecondaryPointOfTwoFingerTap(FFI)V
    .locals 1
    .param p1, "x"    # F
    .param p2, "y"    # F
    .param p3, "pid"    # I

    .prologue
    .line 216
    new-instance v0, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;-><init>(Lcom/adobe/air/gestures/AIRGestureListener;FFI)V

    iput-object v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSecondaryPointOfTwoFingerTap:Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    .line 217
    return-void
.end method

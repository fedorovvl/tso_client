.class public Lcom/adobe/air/wand/view/GestureListener;
.super Ljava/lang/Object;
.source "GestureListener.java"

# interfaces
.implements Landroid/view/GestureDetector$OnGestureListener;
.implements Landroid/view/GestureDetector$OnDoubleTapListener;
.implements Landroid/view/ScaleGestureDetector$OnScaleGestureListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adobe/air/wand/view/GestureListener$TouchPoint;
    }
.end annotation


# static fields
.field private static final LOG_TAG:Ljava/lang/String; = "GestureListener"

.field private static final MAX_TOUCH_POINTS:I = 0x2

.field private static final MM_PER_INCH:F = 25.4f

.field private static final _FP_GESTURE_PAN_THRESHOLD_MM:F = 3.0f

.field private static final _FP_GESTURE_ROTATION_THRESHOLD_DEGREES:F = 15.0f

.field private static final _FP_GESTURE_SWIPE_PRIMARY_AXIS_MIN_MM:F = 10.0f

.field private static final _FP_GESTURE_SWIPE_SECONDARY_AXIS_MAX_MM:F = 5.0f

.field private static final _FP_GESTURE_ZOOM_PER_AXIS_THRESHOLD_MM:F = 3.0f

.field private static final _FP_GESTURE_ZOOM_THRESHOLD_MM:F = 8.0f

.field public static final kGestureAll:I = 0x8

.field public static final kGestureBegin:I = 0x2

.field public static final kGestureEnd:I = 0x4

.field public static final kGesturePan:I = 0x1

.field public static final kGestureRotate:I = 0x2

.field public static final kGestureSwipe:I = 0x4

.field public static final kGestureTap:I = 0x3

.field public static final kGestureUpdate:I = 0x1

.field public static final kGestureZoom:I

.field private static screenPPI:I


# instance fields
.field private mCheckForSwipe:Z

.field private mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

.field private mCouldBeTwoFingerTap:I

.field private mDidOccurTwoFingerGesture:Z

.field private mDownTouchPoints:[Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

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

.field private mPrimaryPointOfTwoFingerTap:Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

.field private mSecondaryPointOfTwoFingerTap:Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

.field private mTwoFingerTapStartTime:J


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 59
    const/4 v0, 0x0

    sput v0, Lcom/adobe/air/wand/view/GestureListener;->screenPPI:I

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lcom/adobe/air/wand/view/CompanionView;)V
    .locals 7
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "aView"    # Lcom/adobe/air/wand/view/CompanionView;

    .prologue
    const/4 v6, 0x2

    const/4 v5, 0x0

    const/4 v4, 0x0

    const/4 v2, 0x0

    .line 140
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 61
    iput v2, p0, Lcom/adobe/air/wand/view/GestureListener;->mPreviousAbsoluteRotation:F

    .line 62
    iput-boolean v4, p0, Lcom/adobe/air/wand/view/GestureListener;->mInRotateTransformGesture:Z

    .line 63
    iput-boolean v4, p0, Lcom/adobe/air/wand/view/GestureListener;->mInZoomTransformGesture:Z

    .line 64
    iput-boolean v4, p0, Lcom/adobe/air/wand/view/GestureListener;->mInZoomTransformGestureX:Z

    .line 65
    iput-boolean v4, p0, Lcom/adobe/air/wand/view/GestureListener;->mInZoomTransformGestureY:Z

    .line 66
    iput-boolean v4, p0, Lcom/adobe/air/wand/view/GestureListener;->mInPanTransformGesture:Z

    .line 68
    iput v2, p0, Lcom/adobe/air/wand/view/GestureListener;->mPreviousRotateLocX:F

    .line 69
    iput v2, p0, Lcom/adobe/air/wand/view/GestureListener;->mPreviousRotateLocY:F

    .line 70
    iput v2, p0, Lcom/adobe/air/wand/view/GestureListener;->mPreviousZoomLocX:F

    .line 71
    iput v2, p0, Lcom/adobe/air/wand/view/GestureListener;->mPreviousZoomLocY:F

    .line 72
    iput v2, p0, Lcom/adobe/air/wand/view/GestureListener;->mPreviousPanLocX:F

    .line 73
    iput v2, p0, Lcom/adobe/air/wand/view/GestureListener;->mPreviousPanLocY:F

    .line 75
    const-wide/16 v2, 0x0

    iput-wide v2, p0, Lcom/adobe/air/wand/view/GestureListener;->mTwoFingerTapStartTime:J

    .line 76
    iput-boolean v4, p0, Lcom/adobe/air/wand/view/GestureListener;->mDidOccurTwoFingerGesture:Z

    .line 78
    iput-object v5, p0, Lcom/adobe/air/wand/view/GestureListener;->mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

    .line 88
    iput v4, p0, Lcom/adobe/air/wand/view/GestureListener;->mCouldBeTwoFingerTap:I

    .line 89
    iput-object v5, p0, Lcom/adobe/air/wand/view/GestureListener;->mSecondaryPointOfTwoFingerTap:Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    .line 90
    iput-object v5, p0, Lcom/adobe/air/wand/view/GestureListener;->mPrimaryPointOfTwoFingerTap:Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    .line 91
    const/4 v2, 0x1

    iput-boolean v2, p0, Lcom/adobe/air/wand/view/GestureListener;->mCheckForSwipe:Z

    .line 141
    iput-object p2, p0, Lcom/adobe/air/wand/view/GestureListener;->mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

    .line 143
    new-array v2, v6, [Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    iput-object v2, p0, Lcom/adobe/air/wand/view/GestureListener;->mDownTouchPoints:[Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    .line 144
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, v6, :cond_0

    .line 146
    iget-object v2, p0, Lcom/adobe/air/wand/view/GestureListener;->mDownTouchPoints:[Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    new-instance v3, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    invoke-direct {v3, p0}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;-><init>(Lcom/adobe/air/wand/view/GestureListener;)V

    aput-object v3, v2, v0

    .line 144
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 149
    :cond_0
    new-instance v2, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    invoke-direct {v2, p0}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;-><init>(Lcom/adobe/air/wand/view/GestureListener;)V

    iput-object v2, p0, Lcom/adobe/air/wand/view/GestureListener;->mSecondaryPointOfTwoFingerTap:Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    .line 150
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    .line 151
    .local v1, "metrics":Landroid/util/DisplayMetrics;
    iget v2, v1, Landroid/util/DisplayMetrics;->xdpi:F

    iget v3, v1, Landroid/util/DisplayMetrics;->ydpi:F

    add-float/2addr v2, v3

    const/high16 v3, 0x40000000    # 2.0f

    div-float/2addr v2, v3

    float-to-int v2, v2

    sput v2, Lcom/adobe/air/wand/view/GestureListener;->screenPPI:I

    .line 152
    return-void
.end method

.method private endPanGesture()V
    .locals 11

    .prologue
    .line 308
    iget-object v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

    invoke-virtual {v0}, Lcom/adobe/air/wand/view/CompanionView;->getMultitouchMode()I

    move-result v0

    iget-object v3, p0, Lcom/adobe/air/wand/view/GestureListener;->mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    const/4 v3, 0x2

    if-eq v0, v3, :cond_1

    .line 330
    :cond_0
    :goto_0
    return-void

    .line 312
    :cond_1
    iget-boolean v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mInPanTransformGesture:Z

    if-eqz v0, :cond_0

    .line 314
    const/4 v1, 0x4

    .line 315
    .local v1, "gesturePhase":I
    const/4 v2, 0x1

    .line 316
    .local v2, "gestureType":I
    const/4 v4, 0x0

    .line 317
    .local v4, "locX":F
    const/4 v5, 0x0

    .line 318
    .local v5, "locY":F
    const/high16 v6, 0x3f800000    # 1.0f

    .line 319
    .local v6, "scaleX":F
    const/high16 v7, 0x3f800000    # 1.0f

    .line 320
    .local v7, "scaleY":F
    const/4 v8, 0x0

    .line 321
    .local v8, "rotation":F
    const/4 v9, 0x0

    .line 322
    .local v9, "offsetX":F
    const/4 v10, 0x0

    .line 324
    .local v10, "offsetY":F
    iget v4, p0, Lcom/adobe/air/wand/view/GestureListener;->mPreviousPanLocX:F

    .line 325
    iget v5, p0, Lcom/adobe/air/wand/view/GestureListener;->mPreviousPanLocY:F

    .line 327
    iget-object v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

    const/4 v3, 0x1

    invoke-virtual/range {v0 .. v10}, Lcom/adobe/air/wand/view/CompanionView;->onGestureListener(IIZFFFFFFF)V

    .line 328
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mInPanTransformGesture:Z

    goto :goto_0
.end method

.method private endRotateGesture()V
    .locals 11

    .prologue
    .line 254
    iget-object v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

    invoke-virtual {v0}, Lcom/adobe/air/wand/view/CompanionView;->getMultitouchMode()I

    move-result v0

    iget-object v3, p0, Lcom/adobe/air/wand/view/GestureListener;->mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    const/4 v3, 0x2

    if-eq v0, v3, :cond_1

    .line 276
    :cond_0
    :goto_0
    return-void

    .line 258
    :cond_1
    iget-boolean v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mInRotateTransformGesture:Z

    if-eqz v0, :cond_0

    .line 260
    const/4 v1, 0x4

    .line 261
    .local v1, "gesturePhase":I
    const/4 v2, 0x2

    .line 262
    .local v2, "gestureType":I
    const/4 v4, 0x0

    .line 263
    .local v4, "locX":F
    const/4 v5, 0x0

    .line 264
    .local v5, "locY":F
    const/high16 v6, 0x3f800000    # 1.0f

    .line 265
    .local v6, "scaleX":F
    const/high16 v7, 0x3f800000    # 1.0f

    .line 266
    .local v7, "scaleY":F
    const/4 v8, 0x0

    .line 267
    .local v8, "rotation":F
    const/4 v9, 0x0

    .line 268
    .local v9, "offsetX":F
    const/4 v10, 0x0

    .line 270
    .local v10, "offsetY":F
    iget v4, p0, Lcom/adobe/air/wand/view/GestureListener;->mPreviousRotateLocX:F

    .line 271
    iget v5, p0, Lcom/adobe/air/wand/view/GestureListener;->mPreviousRotateLocY:F

    .line 273
    iget-object v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

    const/4 v3, 0x1

    invoke-virtual/range {v0 .. v10}, Lcom/adobe/air/wand/view/CompanionView;->onGestureListener(IIZFFFFFFF)V

    .line 274
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mInRotateTransformGesture:Z

    goto :goto_0
.end method

.method private endZoomGesture()V
    .locals 12

    .prologue
    const/4 v11, 0x0

    .line 280
    iget-object v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

    invoke-virtual {v0}, Lcom/adobe/air/wand/view/CompanionView;->getMultitouchMode()I

    move-result v0

    iget-object v3, p0, Lcom/adobe/air/wand/view/GestureListener;->mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    const/4 v3, 0x2

    if-eq v0, v3, :cond_1

    .line 304
    :cond_0
    :goto_0
    return-void

    .line 284
    :cond_1
    iget-boolean v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mInZoomTransformGesture:Z

    if-eqz v0, :cond_0

    .line 286
    const/4 v1, 0x4

    .line 287
    .local v1, "gesturePhase":I
    const/4 v2, 0x0

    .line 288
    .local v2, "gestureType":I
    const/4 v4, 0x0

    .line 289
    .local v4, "locX":F
    const/4 v5, 0x0

    .line 290
    .local v5, "locY":F
    const/high16 v6, 0x3f800000    # 1.0f

    .line 291
    .local v6, "scaleX":F
    const/high16 v7, 0x3f800000    # 1.0f

    .line 292
    .local v7, "scaleY":F
    const/4 v8, 0x0

    .line 293
    .local v8, "rotation":F
    const/4 v9, 0x0

    .line 294
    .local v9, "offsetX":F
    const/4 v10, 0x0

    .line 296
    .local v10, "offsetY":F
    iget v4, p0, Lcom/adobe/air/wand/view/GestureListener;->mPreviousZoomLocX:F

    .line 297
    iget v5, p0, Lcom/adobe/air/wand/view/GestureListener;->mPreviousZoomLocY:F

    .line 299
    iget-object v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

    const/4 v3, 0x1

    invoke-virtual/range {v0 .. v10}, Lcom/adobe/air/wand/view/CompanionView;->onGestureListener(IIZFFFFFFF)V

    .line 300
    iput-boolean v11, p0, Lcom/adobe/air/wand/view/GestureListener;->mInZoomTransformGesture:Z

    .line 301
    iput-boolean v11, p0, Lcom/adobe/air/wand/view/GestureListener;->mInZoomTransformGestureX:Z

    .line 302
    iput-boolean v11, p0, Lcom/adobe/air/wand/view/GestureListener;->mInZoomTransformGestureY:Z

    goto :goto_0
.end method

.method private getRotation(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;Lcom/adobe/air/wand/view/GestureListener$TouchPoint;Lcom/adobe/air/wand/view/GestureListener$TouchPoint;Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F
    .locals 10
    .param p1, "initial_pt1"    # Lcom/adobe/air/wand/view/GestureListener$TouchPoint;
    .param p2, "initial_pt2"    # Lcom/adobe/air/wand/view/GestureListener$TouchPoint;
    .param p3, "current_pt1"    # Lcom/adobe/air/wand/view/GestureListener$TouchPoint;
    .param p4, "current_pt2"    # Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    .prologue
    .line 825
    const/4 v0, 0x0

    .line 826
    .local v0, "rotation":F
    invoke-static {p1}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$100(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)I

    move-result v1

    invoke-static {p3}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$100(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)I

    move-result v6

    if-ne v1, v6, :cond_0

    invoke-static {p2}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$100(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)I

    move-result v1

    invoke-static {p4}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$100(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)I

    move-result v6

    if-ne v1, v6, :cond_0

    .line 829
    invoke-static {p2}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$300(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F

    move-result v1

    invoke-static {p1}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$300(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F

    move-result v6

    sub-float/2addr v1, v6

    float-to-double v6, v1

    invoke-static {p2}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$200(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F

    move-result v1

    invoke-static {p1}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$200(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F

    move-result v8

    sub-float/2addr v1, v8

    float-to-double v8, v1

    invoke-static {v6, v7, v8, v9}, Ljava/lang/Math;->atan2(DD)D

    move-result-wide v6

    const-wide v8, 0x4066800000000000L    # 180.0

    mul-double/2addr v6, v8

    const-wide v8, 0x400921fb54442d18L    # Math.PI

    div-double v4, v6, v8

    .line 831
    .local v4, "theta_initial":D
    invoke-static {p4}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$300(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F

    move-result v1

    invoke-static {p3}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$300(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F

    move-result v6

    sub-float/2addr v1, v6

    float-to-double v6, v1

    invoke-static {p4}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$200(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F

    move-result v1

    invoke-static {p3}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$200(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F

    move-result v8

    sub-float/2addr v1, v8

    float-to-double v8, v1

    invoke-static {v6, v7, v8, v9}, Ljava/lang/Math;->atan2(DD)D

    move-result-wide v6

    const-wide v8, 0x4066800000000000L    # 180.0

    mul-double/2addr v6, v8

    const-wide v8, 0x400921fb54442d18L    # Math.PI

    div-double v2, v6, v8

    .line 833
    .local v2, "theta_current":D
    sub-double v6, v2, v4

    double-to-float v0, v6

    .line 836
    .end local v2    # "theta_current":D
    .end local v4    # "theta_initial":D
    :cond_0
    return v0
.end method

.method private isPanGesture(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;Lcom/adobe/air/wand/view/GestureListener$TouchPoint;Lcom/adobe/air/wand/view/GestureListener$TouchPoint;Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)Z
    .locals 11
    .param p1, "initial_pt1"    # Lcom/adobe/air/wand/view/GestureListener$TouchPoint;
    .param p2, "initial_pt2"    # Lcom/adobe/air/wand/view/GestureListener$TouchPoint;
    .param p3, "current_pt1"    # Lcom/adobe/air/wand/view/GestureListener$TouchPoint;
    .param p4, "current_pt2"    # Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    .prologue
    const/4 v10, 0x0

    .line 850
    invoke-static {p3}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$200(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F

    move-result v8

    invoke-static {p1}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$200(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F

    move-result v9

    sub-float v2, v8, v9

    .line 851
    .local v2, "delta_pt1_x":F
    invoke-static {p3}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$300(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F

    move-result v8

    invoke-static {p1}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$300(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F

    move-result v9

    sub-float v3, v8, v9

    .line 853
    .local v3, "delta_pt1_y":F
    invoke-static {p4}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$200(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F

    move-result v8

    invoke-static {p2}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$200(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F

    move-result v9

    sub-float v4, v8, v9

    .line 854
    .local v4, "delta_pt2_x":F
    invoke-static {p4}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$300(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F

    move-result v8

    invoke-static {p2}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$300(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F

    move-result v9

    sub-float v5, v8, v9

    .line 856
    .local v5, "delta_pt2_y":F
    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v8

    invoke-static {v4}, Ljava/lang/Math;->abs(F)F

    move-result v9

    invoke-static {v8, v9}, Ljava/lang/Math;->min(FF)F

    move-result v6

    .line 857
    .local v6, "minTranslation_x":F
    invoke-static {v3}, Ljava/lang/Math;->abs(F)F

    move-result v8

    invoke-static {v5}, Ljava/lang/Math;->abs(F)F

    move-result v9

    invoke-static {v8, v9}, Ljava/lang/Math;->min(FF)F

    move-result v7

    .line 858
    .local v7, "minTranslation_y":F
    mul-float v8, v6, v6

    mul-float v9, v7, v7

    add-float/2addr v8, v9

    float-to-double v8, v8

    invoke-static {v8, v9}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v0

    .line 863
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
    iget-boolean v8, p0, Lcom/adobe/air/wand/view/GestureListener;->mInPanTransformGesture:Z

    if-nez v8, :cond_4

    const/high16 v8, 0x40400000    # 3.0f

    sget v9, Lcom/adobe/air/wand/view/GestureListener;->screenPPI:I

    int-to-float v9, v9

    mul-float/2addr v8, v9

    const v9, 0x41cb3333    # 25.4f

    div-float/2addr v8, v9

    float-to-double v8, v8

    cmpl-double v8, v0, v8

    if-lez v8, :cond_5

    .line 871
    :cond_4
    const/4 v8, 0x1

    .line 873
    :goto_0
    return v8

    :cond_5
    const/4 v8, 0x0

    goto :goto_0
.end method


# virtual methods
.method public endTwoFingerGesture()Z
    .locals 7

    .prologue
    const/4 v6, 0x1

    .line 228
    iget-object v2, p0, Lcom/adobe/air/wand/view/GestureListener;->mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

    invoke-virtual {v2}, Lcom/adobe/air/wand/view/CompanionView;->getMultitouchMode()I

    move-result v2

    iget-object v3, p0, Lcom/adobe/air/wand/view/GestureListener;->mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    const/4 v3, 0x2

    if-eq v2, v3, :cond_0

    .line 249
    :goto_0
    return v6

    .line 234
    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    .line 236
    .local v0, "currentTime":J
    iget-boolean v2, p0, Lcom/adobe/air/wand/view/GestureListener;->mDidOccurTwoFingerGesture:Z

    if-nez v2, :cond_1

    iget v2, p0, Lcom/adobe/air/wand/view/GestureListener;->mCouldBeTwoFingerTap:I

    const/4 v3, 0x3

    if-ne v2, v3, :cond_1

    iget-wide v2, p0, Lcom/adobe/air/wand/view/GestureListener;->mTwoFingerTapStartTime:J

    sub-long v2, v0, v2

    .line 238
    invoke-static {}, Landroid/view/ViewConfiguration;->getTapTimeout()I

    move-result v4

    int-to-long v4, v4

    cmp-long v2, v2, v4

    if-gez v2, :cond_1

    .line 240
    invoke-virtual {p0}, Lcom/adobe/air/wand/view/GestureListener;->onTwoFingerTap()Z

    .line 247
    :cond_1
    invoke-direct {p0}, Lcom/adobe/air/wand/view/GestureListener;->endRotateGesture()V

    .line 248
    invoke-direct {p0}, Lcom/adobe/air/wand/view/GestureListener;->endPanGesture()V

    goto :goto_0
.end method

.method public getCheckForSwipe()Z
    .locals 1

    .prologue
    .line 218
    iget-boolean v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mCheckForSwipe:Z

    return v0
.end method

.method public getCouldBeTwoFingerTap()I
    .locals 1

    .prologue
    .line 194
    iget v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mCouldBeTwoFingerTap:I

    return v0
.end method

.method public getDownTouchPoint(I)Lcom/adobe/air/wand/view/GestureListener$TouchPoint;
    .locals 1
    .param p1, "pid"    # I

    .prologue
    .line 161
    if-ltz p1, :cond_0

    const/4 v0, 0x2

    if-ge p1, v0, :cond_0

    .line 162
    iget-object v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mDownTouchPoints:[Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    aget-object v0, v0, p1

    .line 164
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

    .line 209
    iput-boolean v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mInRotateTransformGesture:Z

    .line 210
    iput-boolean v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mInZoomTransformGesture:Z

    .line 211
    iput-boolean v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mInZoomTransformGestureX:Z

    .line 212
    iput-boolean v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mInZoomTransformGestureY:Z

    .line 213
    iput-boolean v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mInPanTransformGesture:Z

    .line 214
    return-void
.end method

.method public onDoubleTap(Landroid/view/MotionEvent;)Z
    .locals 1
    .param p1, "e"    # Landroid/view/MotionEvent;

    .prologue
    .line 878
    const/4 v0, 0x0

    return v0
.end method

.method public onDoubleTapEvent(Landroid/view/MotionEvent;)Z
    .locals 1
    .param p1, "e"    # Landroid/view/MotionEvent;

    .prologue
    .line 671
    const/4 v0, 0x1

    return v0
.end method

.method public onDown(Landroid/view/MotionEvent;)Z
    .locals 1
    .param p1, "e"    # Landroid/view/MotionEvent;

    .prologue
    .line 340
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
    .line 348
    const/4 v0, 0x1

    return v0
.end method

.method public onLongPress(Landroid/view/MotionEvent;)V
    .locals 0
    .param p1, "e"    # Landroid/view/MotionEvent;

    .prologue
    .line 356
    return-void
.end method

.method public onScale(Landroid/view/ScaleGestureDetector;)Z
    .locals 28
    .param p1, "detector"    # Landroid/view/ScaleGestureDetector;

    .prologue
    .line 702
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/wand/view/GestureListener;->mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

    invoke-virtual {v2}, Lcom/adobe/air/wand/view/CompanionView;->getMultitouchMode()I

    move-result v2

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/adobe/air/wand/view/GestureListener;->mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

    invoke-virtual {v5}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    const/4 v5, 0x2

    if-eq v2, v5, :cond_0

    .line 703
    const/4 v2, 0x1

    .line 785
    :goto_0
    return v2

    .line 707
    :cond_0
    const/4 v3, 0x1

    .line 708
    .local v3, "gesturePhase":I
    const/4 v4, 0x0

    .line 710
    .local v4, "gestureType":I
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getFocusX()F

    move-result v6

    .line 711
    .local v6, "locX":F
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getFocusY()F

    move-result v7

    .line 713
    .local v7, "locY":F
    const/high16 v8, 0x3f800000    # 1.0f

    .line 714
    .local v8, "scaleX":F
    const/high16 v9, 0x3f800000    # 1.0f

    .line 715
    .local v9, "scaleY":F
    const/4 v10, 0x0

    .line 716
    .local v10, "rotation":F
    const/4 v11, 0x0

    .line 717
    .local v11, "offsetX":F
    const/4 v12, 0x0

    .line 719
    .local v12, "offsetY":F
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getPreviousSpan()F

    move-result v2

    float-to-double v0, v2

    move-wide/from16 v22, v0

    .line 720
    .local v22, "initialDistance":D
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getCurrentSpan()F

    move-result v2

    float-to-double v14, v2

    .line 721
    .local v14, "currentDistance":D
    sub-double v24, v14, v22

    invoke-static/range {v24 .. v25}, Ljava/lang/Math;->abs(D)D

    move-result-wide v16

    .line 722
    .local v16, "deltaDistance":D
    const-wide/16 v18, 0x0

    .line 723
    .local v18, "deltaDistanceX":D
    const-wide/16 v20, 0x0

    .line 724
    .local v20, "deltaDistanceY":D
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v5, 0xb

    if-lt v2, v5, :cond_1

    .line 726
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getCurrentSpanX()F

    move-result v2

    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getPreviousSpanX()F

    move-result v5

    sub-float/2addr v2, v5

    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v2

    float-to-double v0, v2

    move-wide/from16 v18, v0

    .line 727
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getCurrentSpanY()F

    move-result v2

    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getPreviousSpanY()F

    move-result v5

    sub-float/2addr v2, v5

    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v2

    float-to-double v0, v2

    move-wide/from16 v20, v0

    .line 730
    :cond_1
    const-wide/16 v24, 0x0

    cmpl-double v2, v22, v24

    if-eqz v2, :cond_a

    .line 732
    move-object/from16 v0, p0

    iget-boolean v2, v0, Lcom/adobe/air/wand/view/GestureListener;->mInZoomTransformGesture:Z

    if-nez v2, :cond_2

    const-wide v24, 0x4039666660000000L    # 25.399999618530273

    mul-double v24, v24, v16

    sget v2, Lcom/adobe/air/wand/view/GestureListener;->screenPPI:I

    int-to-double v0, v2

    move-wide/from16 v26, v0

    div-double v24, v24, v26

    const-wide/high16 v26, 0x4020000000000000L    # 8.0

    cmpl-double v2, v24, v26

    if-lez v2, :cond_9

    .line 734
    :cond_2
    move-object/from16 v0, p0

    iget-boolean v2, v0, Lcom/adobe/air/wand/view/GestureListener;->mInZoomTransformGesture:Z

    if-nez v2, :cond_3

    .line 736
    const/4 v2, 0x1

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/adobe/air/wand/view/GestureListener;->mInZoomTransformGesture:Z

    .line 737
    const/4 v3, 0x2

    .line 738
    const/4 v2, 0x1

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/adobe/air/wand/view/GestureListener;->mDidOccurTwoFingerGesture:Z

    .line 743
    :cond_3
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v5, 0xb

    if-lt v2, v5, :cond_8

    .line 745
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

    iget-boolean v2, v0, Lcom/adobe/air/wand/view/GestureListener;->mInZoomTransformGestureX:Z

    if-nez v2, :cond_4

    const-wide v24, 0x4039666660000000L    # 25.399999618530273

    mul-double v24, v24, v18

    sget v2, Lcom/adobe/air/wand/view/GestureListener;->screenPPI:I

    int-to-double v0, v2

    move-wide/from16 v26, v0

    div-double v24, v24, v26

    const-wide/high16 v26, 0x4008000000000000L    # 3.0

    cmpl-double v2, v24, v26

    if-lez v2, :cond_5

    .line 748
    :cond_4
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getCurrentSpanX()F

    move-result v2

    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getPreviousSpanX()F

    move-result v5

    div-float/2addr v2, v5

    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v8

    .line 749
    const/4 v2, 0x1

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/adobe/air/wand/view/GestureListener;->mInZoomTransformGestureX:Z

    .line 752
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

    iget-boolean v2, v0, Lcom/adobe/air/wand/view/GestureListener;->mInZoomTransformGestureY:Z

    if-nez v2, :cond_6

    const-wide v24, 0x4039666660000000L    # 25.399999618530273

    mul-double v24, v24, v20

    sget v2, Lcom/adobe/air/wand/view/GestureListener;->screenPPI:I

    int-to-double v0, v2

    move-wide/from16 v26, v0

    div-double v24, v24, v26

    const-wide/high16 v26, 0x4008000000000000L    # 3.0

    cmpl-double v2, v24, v26

    if-lez v2, :cond_7

    .line 755
    :cond_6
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getCurrentSpanY()F

    move-result v2

    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getPreviousSpanY()F

    move-result v5

    div-float/2addr v2, v5

    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v9

    .line 756
    const/4 v2, 0x1

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/adobe/air/wand/view/GestureListener;->mInZoomTransformGestureY:Z

    .line 771
    :cond_7
    :goto_1
    move-object/from16 v0, p0

    iput v6, v0, Lcom/adobe/air/wand/view/GestureListener;->mPreviousZoomLocX:F

    .line 772
    move-object/from16 v0, p0

    iput v7, v0, Lcom/adobe/air/wand/view/GestureListener;->mPreviousZoomLocY:F

    .line 775
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/adobe/air/wand/view/GestureListener;->mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

    const/4 v5, 0x1

    invoke-virtual/range {v2 .. v12}, Lcom/adobe/air/wand/view/CompanionView;->onGestureListener(IIZFFFFFFF)V

    .line 777
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 761
    :cond_8
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getScaleFactor()F

    move-result v13

    .line 764
    .local v13, "scaleFactor":F
    move v8, v13

    .line 765
    move v9, v13

    goto :goto_1

    .line 782
    .end local v13    # "scaleFactor":F
    :cond_9
    const/4 v2, 0x0

    goto/16 :goto_0

    .line 785
    :cond_a
    const/4 v2, 0x0

    goto/16 :goto_0
.end method

.method public onScaleBegin(Landroid/view/ScaleGestureDetector;)Z
    .locals 1
    .param p1, "detector"    # Landroid/view/ScaleGestureDetector;

    .prologue
    .line 683
    iget-boolean v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mInZoomTransformGesture:Z

    if-eqz v0, :cond_0

    .line 686
    invoke-direct {p0}, Lcom/adobe/air/wand/view/GestureListener;->endZoomGesture()V

    .line 692
    :cond_0
    const/4 v0, 0x1

    return v0
.end method

.method public onScaleEnd(Landroid/view/ScaleGestureDetector;)V
    .locals 11
    .param p1, "detector"    # Landroid/view/ScaleGestureDetector;

    .prologue
    const/4 v8, 0x0

    .line 795
    iget-object v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

    invoke-virtual {v0}, Lcom/adobe/air/wand/view/CompanionView;->getMultitouchMode()I

    move-result v0

    iget-object v1, p0, Lcom/adobe/air/wand/view/GestureListener;->mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    const/4 v1, 0x2

    if-eq v0, v1, :cond_1

    .line 812
    :cond_0
    :goto_0
    return-void

    .line 802
    :cond_1
    iget-boolean v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mInZoomTransformGesture:Z

    if-eqz v0, :cond_0

    .line 804
    invoke-virtual {p1}, Landroid/view/ScaleGestureDetector;->getScaleFactor()F

    move-result v6

    .line 810
    .local v6, "scaleFactor":F
    iget-object v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

    const/4 v1, 0x4

    const/4 v2, 0x0

    const/4 v3, 0x1

    iget v4, p0, Lcom/adobe/air/wand/view/GestureListener;->mPreviousZoomLocX:F

    iget v5, p0, Lcom/adobe/air/wand/view/GestureListener;->mPreviousZoomLocY:F

    move v7, v6

    move v9, v8

    move v10, v8

    invoke-virtual/range {v0 .. v10}, Lcom/adobe/air/wand/view/CompanionView;->onGestureListener(IIZFFFFFFF)V

    goto :goto_0
.end method

.method public onScroll(Landroid/view/MotionEvent;Landroid/view/MotionEvent;FF)Z
    .locals 25
    .param p1, "e1"    # Landroid/view/MotionEvent;
    .param p2, "e2"    # Landroid/view/MotionEvent;
    .param p3, "distanceX"    # F
    .param p4, "distanceY"    # F

    .prologue
    .line 364
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/adobe/air/wand/view/GestureListener;->mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

    invoke-virtual {v3}, Lcom/adobe/air/wand/view/CompanionView;->getMultitouchMode()I

    move-result v3

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/adobe/air/wand/view/GestureListener;->mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    const/4 v6, 0x2

    if-eq v3, v6, :cond_0

    .line 365
    const/4 v3, 0x1

    .line 605
    :goto_0
    return v3

    .line 372
    :cond_0
    const/4 v4, 0x2

    .line 373
    .local v4, "gesturePhase":I
    const/4 v5, 0x2

    .line 374
    .local v5, "gestureType":I
    const/4 v7, 0x0

    .line 375
    .local v7, "locX":F
    const/4 v8, 0x0

    .line 376
    .local v8, "locY":F
    const/high16 v9, 0x3f800000    # 1.0f

    .line 377
    .local v9, "scaleX":F
    const/high16 v10, 0x3f800000    # 1.0f

    .line 378
    .local v10, "scaleY":F
    const/4 v11, 0x0

    .line 379
    .local v11, "rotation":F
    const/4 v12, 0x0

    .line 380
    .local v12, "offsetX":F
    const/4 v13, 0x0

    .line 386
    .local v13, "offsetY":F
    invoke-virtual/range {p2 .. p2}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v3

    const/4 v6, 0x2

    if-ne v3, v6, :cond_c

    .line 391
    const/4 v4, 0x1

    .line 393
    const/4 v3, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v3}, Landroid/view/MotionEvent;->getX(I)F

    move-result v3

    const/4 v6, 0x1

    move-object/from16 v0, p2

    invoke-virtual {v0, v6}, Landroid/view/MotionEvent;->getX(I)F

    move-result v6

    add-float/2addr v3, v6

    const/high16 v6, 0x40000000    # 2.0f

    div-float v7, v3, v6

    .line 394
    const/4 v3, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v3}, Landroid/view/MotionEvent;->getY(I)F

    move-result v3

    const/4 v6, 0x1

    move-object/from16 v0, p2

    invoke-virtual {v0, v6}, Landroid/view/MotionEvent;->getY(I)F

    move-result v6

    add-float/2addr v3, v6

    const/high16 v6, 0x40000000    # 2.0f

    div-float v8, v3, v6

    .line 399
    const/4 v3, 0x2

    new-array v15, v3, [Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    .line 401
    .local v15, "currentTouchPoint":[Lcom/adobe/air/wand/view/GestureListener$TouchPoint;
    const/16 v18, 0x0

    .local v18, "i":I
    :goto_1
    const/4 v3, 0x2

    move/from16 v0, v18

    if-ge v0, v3, :cond_1

    .line 403
    new-instance v3, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    move-object/from16 v0, p2

    move/from16 v1, v18

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getX(I)F

    move-result v6

    move-object/from16 v0, p2

    move/from16 v1, v18

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getY(I)F

    move-result v23

    move-object/from16 v0, p2

    move/from16 v1, v18

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v24

    move-object/from16 v0, p0

    move/from16 v1, v23

    move/from16 v2, v24

    invoke-direct {v3, v0, v6, v1, v2}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;-><init>(Lcom/adobe/air/wand/view/GestureListener;FFI)V

    aput-object v3, v15, v18

    .line 401
    add-int/lit8 v18, v18, 0x1

    goto :goto_1

    .line 406
    :cond_1
    const/4 v3, 0x0

    aget-object v3, v15, v3

    invoke-static {v3}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$100(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)I

    move-result v20

    .line 407
    .local v20, "pid1":I
    const/4 v3, 0x1

    aget-object v3, v15, v3

    invoke-static {v3}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$100(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)I

    move-result v21

    .line 409
    .local v21, "pid2":I
    if-ltz v20, :cond_8

    const/4 v3, 0x2

    move/from16 v0, v20

    if-ge v0, v3, :cond_8

    if-ltz v21, :cond_8

    const/4 v3, 0x2

    move/from16 v0, v21

    if-ge v0, v3, :cond_8

    .line 415
    move-object/from16 v0, p0

    iget-boolean v3, v0, Lcom/adobe/air/wand/view/GestureListener;->mInPanTransformGesture:Z

    if-nez v3, :cond_6

    .line 424
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/adobe/air/wand/view/GestureListener;->mDownTouchPoints:[Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    aget-object v3, v3, v20

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/adobe/air/wand/view/GestureListener;->mDownTouchPoints:[Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    aget-object v6, v6, v21

    const/16 v23, 0x0

    aget-object v23, v15, v23

    const/16 v24, 0x1

    aget-object v24, v15, v24

    move-object/from16 v0, p0

    move-object/from16 v1, v23

    move-object/from16 v2, v24

    invoke-direct {v0, v3, v6, v1, v2}, Lcom/adobe/air/wand/view/GestureListener;->getRotation(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;Lcom/adobe/air/wand/view/GestureListener$TouchPoint;Lcom/adobe/air/wand/view/GestureListener$TouchPoint;Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F

    move-result v14

    .line 429
    .local v14, "absoluteRotation":F
    invoke-static {v14}, Ljava/lang/Math;->abs(F)F

    move-result v3

    const/high16 v6, 0x43340000    # 180.0f

    cmpl-float v3, v3, v6

    if-lez v3, :cond_2

    .line 431
    const/4 v3, 0x0

    cmpl-float v3, v14, v3

    if-lez v3, :cond_9

    const/high16 v3, 0x43b40000    # 360.0f

    sub-float/2addr v3, v14

    const/high16 v6, -0x40800000    # -1.0f

    mul-float v14, v3, v6

    .line 437
    :cond_2
    :goto_2
    move-object/from16 v0, p0

    iget-boolean v3, v0, Lcom/adobe/air/wand/view/GestureListener;->mInRotateTransformGesture:Z

    if-nez v3, :cond_3

    invoke-static {v14}, Ljava/lang/Math;->abs(F)F

    move-result v3

    const/high16 v6, 0x41700000    # 15.0f

    cmpl-float v3, v3, v6

    if-lez v3, :cond_6

    .line 439
    :cond_3
    const/4 v5, 0x2

    .line 440
    move-object/from16 v0, p0

    iget-boolean v3, v0, Lcom/adobe/air/wand/view/GestureListener;->mInRotateTransformGesture:Z

    if-nez v3, :cond_4

    .line 442
    const/4 v4, 0x2

    .line 443
    const/4 v3, 0x1

    move-object/from16 v0, p0

    iput-boolean v3, v0, Lcom/adobe/air/wand/view/GestureListener;->mInRotateTransformGesture:Z

    .line 444
    const/4 v3, 0x0

    move-object/from16 v0, p0

    iput v3, v0, Lcom/adobe/air/wand/view/GestureListener;->mPreviousAbsoluteRotation:F

    .line 445
    const/4 v3, 0x1

    move-object/from16 v0, p0

    iput-boolean v3, v0, Lcom/adobe/air/wand/view/GestureListener;->mDidOccurTwoFingerGesture:Z

    .line 448
    :cond_4
    move-object/from16 v0, p0

    iget v3, v0, Lcom/adobe/air/wand/view/GestureListener;->mPreviousAbsoluteRotation:F

    sub-float v11, v14, v3

    .line 453
    invoke-static {v11}, Ljava/lang/Math;->abs(F)F

    move-result v3

    const/high16 v6, 0x43340000    # 180.0f

    cmpl-float v3, v3, v6

    if-lez v3, :cond_5

    .line 455
    const/4 v3, 0x0

    cmpl-float v3, v11, v3

    if-lez v3, :cond_a

    const/high16 v3, 0x43b40000    # 360.0f

    sub-float/2addr v3, v11

    const/high16 v6, -0x40800000    # -1.0f

    mul-float v11, v3, v6

    .line 460
    :cond_5
    :goto_3
    move-object/from16 v0, p0

    iput v14, v0, Lcom/adobe/air/wand/view/GestureListener;->mPreviousAbsoluteRotation:F

    .line 461
    move-object/from16 v0, p0

    iput v7, v0, Lcom/adobe/air/wand/view/GestureListener;->mPreviousRotateLocX:F

    .line 462
    move-object/from16 v0, p0

    iput v8, v0, Lcom/adobe/air/wand/view/GestureListener;->mPreviousRotateLocY:F

    .line 465
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/adobe/air/wand/view/GestureListener;->mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

    const/4 v6, 0x1

    invoke-virtual/range {v3 .. v13}, Lcom/adobe/air/wand/view/CompanionView;->onGestureListener(IIZFFFFFFF)V

    .line 468
    const/4 v11, 0x0

    .line 476
    .end local v14    # "absoluteRotation":F
    :cond_6
    move-object/from16 v0, p0

    iget-boolean v3, v0, Lcom/adobe/air/wand/view/GestureListener;->mInZoomTransformGesture:Z

    if-nez v3, :cond_8

    move-object/from16 v0, p0

    iget-boolean v3, v0, Lcom/adobe/air/wand/view/GestureListener;->mInRotateTransformGesture:Z

    if-nez v3, :cond_8

    .line 479
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/adobe/air/wand/view/GestureListener;->mDownTouchPoints:[Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    aget-object v3, v3, v20

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/adobe/air/wand/view/GestureListener;->mDownTouchPoints:[Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    aget-object v6, v6, v21

    const/16 v23, 0x0

    aget-object v23, v15, v23

    const/16 v24, 0x1

    aget-object v24, v15, v24

    move-object/from16 v0, p0

    move-object/from16 v1, v23

    move-object/from16 v2, v24

    invoke-direct {v0, v3, v6, v1, v2}, Lcom/adobe/air/wand/view/GestureListener;->isPanGesture(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;Lcom/adobe/air/wand/view/GestureListener$TouchPoint;Lcom/adobe/air/wand/view/GestureListener$TouchPoint;Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)Z

    move-result v3

    if-eqz v3, :cond_b

    .line 484
    const/4 v5, 0x1

    .line 485
    move-object/from16 v0, p0

    iget-boolean v3, v0, Lcom/adobe/air/wand/view/GestureListener;->mInPanTransformGesture:Z

    if-nez v3, :cond_7

    .line 487
    const/4 v4, 0x2

    .line 488
    const/4 v3, 0x1

    move-object/from16 v0, p0

    iput-boolean v3, v0, Lcom/adobe/air/wand/view/GestureListener;->mInPanTransformGesture:Z

    .line 489
    const/4 v3, 0x1

    move-object/from16 v0, p0

    iput-boolean v3, v0, Lcom/adobe/air/wand/view/GestureListener;->mDidOccurTwoFingerGesture:Z

    .line 492
    :cond_7
    const/high16 v3, -0x40800000    # -1.0f

    mul-float v12, v3, p3

    .line 493
    const/high16 v3, -0x40800000    # -1.0f

    mul-float v13, v3, p4

    .line 494
    move-object/from16 v0, p0

    iput v7, v0, Lcom/adobe/air/wand/view/GestureListener;->mPreviousPanLocX:F

    .line 495
    move-object/from16 v0, p0

    iput v8, v0, Lcom/adobe/air/wand/view/GestureListener;->mPreviousPanLocY:F

    .line 500
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/adobe/air/wand/view/GestureListener;->mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

    const/4 v6, 0x1

    invoke-virtual/range {v3 .. v13}, Lcom/adobe/air/wand/view/CompanionView;->onGestureListener(IIZFFFFFFF)V

    .line 503
    const/4 v12, 0x0

    .line 504
    const/4 v13, 0x0

    .line 605
    .end local v15    # "currentTouchPoint":[Lcom/adobe/air/wand/view/GestureListener$TouchPoint;
    .end local v18    # "i":I
    .end local v20    # "pid1":I
    .end local v21    # "pid2":I
    :cond_8
    :goto_4
    const/4 v3, 0x1

    goto/16 :goto_0

    .line 431
    .restart local v14    # "absoluteRotation":F
    .restart local v15    # "currentTouchPoint":[Lcom/adobe/air/wand/view/GestureListener$TouchPoint;
    .restart local v18    # "i":I
    .restart local v20    # "pid1":I
    .restart local v21    # "pid2":I
    :cond_9
    const/high16 v3, 0x43b40000    # 360.0f

    add-float/2addr v14, v3

    goto/16 :goto_2

    .line 455
    :cond_a
    const/high16 v3, 0x43b40000    # 360.0f

    add-float/2addr v11, v3

    goto :goto_3

    .line 508
    .end local v14    # "absoluteRotation":F
    :cond_b
    move-object/from16 v0, p0

    iget-boolean v3, v0, Lcom/adobe/air/wand/view/GestureListener;->mInPanTransformGesture:Z

    if-eqz v3, :cond_8

    .line 511
    invoke-direct/range {p0 .. p0}, Lcom/adobe/air/wand/view/GestureListener;->endPanGesture()V

    .line 512
    const/4 v3, 0x0

    aget-object v3, v15, v3

    invoke-static {v3}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$200(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F

    move-result v3

    const/4 v6, 0x0

    aget-object v6, v15, v6

    invoke-static {v6}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$300(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F

    move-result v6

    const/16 v23, 0x0

    aget-object v23, v15, v23

    invoke-static/range {v23 .. v23}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$100(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)I

    move-result v23

    move-object/from16 v0, p0

    move/from16 v1, v23

    invoke-virtual {v0, v3, v6, v1}, Lcom/adobe/air/wand/view/GestureListener;->setDownTouchPoint(FFI)V

    .line 513
    const/4 v3, 0x1

    aget-object v3, v15, v3

    invoke-static {v3}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$200(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F

    move-result v3

    const/4 v6, 0x1

    aget-object v6, v15, v6

    invoke-static {v6}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$300(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F

    move-result v6

    const/16 v23, 0x1

    aget-object v23, v15, v23

    invoke-static/range {v23 .. v23}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$100(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)I

    move-result v23

    move-object/from16 v0, p0

    move/from16 v1, v23

    invoke-virtual {v0, v3, v6, v1}, Lcom/adobe/air/wand/view/GestureListener;->setDownTouchPoint(FFI)V

    goto :goto_4

    .line 523
    .end local v15    # "currentTouchPoint":[Lcom/adobe/air/wand/view/GestureListener$TouchPoint;
    .end local v18    # "i":I
    .end local v20    # "pid1":I
    .end local v21    # "pid2":I
    :cond_c
    invoke-virtual/range {p2 .. p2}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v3

    const/4 v6, 0x1

    if-ne v3, v6, :cond_8

    .line 525
    const/4 v3, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v3}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v22

    .line 527
    .local v22, "pid_swipe":I
    if-ltz v22, :cond_8

    const/4 v3, 0x2

    move/from16 v0, v22

    if-ge v0, v3, :cond_8

    .line 535
    move-object/from16 v0, p0

    iget-boolean v3, v0, Lcom/adobe/air/wand/view/GestureListener;->mCheckForSwipe:Z

    if-eqz v3, :cond_8

    .line 537
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v3

    const/4 v6, 0x1

    if-ne v3, v6, :cond_8

    .line 539
    const/16 v19, 0x0

    .line 540
    .local v19, "isSwipe":Z
    const/16 v16, 0x0

    .line 541
    .local v16, "delta_x":F
    const/16 v17, 0x0

    .line 543
    .local v17, "delta_y":F
    const/4 v3, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v3}, Landroid/view/MotionEvent;->getX(I)F

    move-result v3

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/adobe/air/wand/view/GestureListener;->mDownTouchPoints:[Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    aget-object v6, v6, v22

    invoke-static {v6}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$200(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F

    move-result v6

    sub-float v16, v3, v6

    .line 544
    const/4 v3, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v3}, Landroid/view/MotionEvent;->getY(I)F

    move-result v3

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/adobe/air/wand/view/GestureListener;->mDownTouchPoints:[Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    aget-object v6, v6, v22

    invoke-static {v6}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$300(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F

    move-result v6

    sub-float v17, v3, v6

    .line 548
    invoke-static/range {v16 .. v16}, Ljava/lang/Math;->abs(F)F

    move-result v3

    const v6, 0x41cb3333    # 25.4f

    mul-float/2addr v3, v6

    sget v6, Lcom/adobe/air/wand/view/GestureListener;->screenPPI:I

    int-to-float v6, v6

    div-float/2addr v3, v6

    const/high16 v6, 0x41200000    # 10.0f

    cmpl-float v3, v3, v6

    if-ltz v3, :cond_e

    invoke-static/range {v17 .. v17}, Ljava/lang/Math;->abs(F)F

    move-result v3

    const v6, 0x41cb3333    # 25.4f

    mul-float/2addr v3, v6

    sget v6, Lcom/adobe/air/wand/view/GestureListener;->screenPPI:I

    int-to-float v6, v6

    div-float/2addr v3, v6

    const/high16 v6, 0x40a00000    # 5.0f

    cmpg-float v3, v3, v6

    if-gtz v3, :cond_e

    .line 550
    const/16 v19, 0x1

    .line 551
    const/4 v3, 0x0

    cmpl-float v3, v16, v3

    if-lez v3, :cond_d

    const/high16 v12, 0x3f800000    # 1.0f

    .line 552
    :goto_5
    const/4 v13, 0x0

    .line 566
    :goto_6
    if-eqz v19, :cond_8

    .line 570
    const/16 v4, 0x8

    .line 571
    const/4 v5, 0x4

    .line 574
    const/4 v3, 0x0

    move-object/from16 v0, p1

    invoke-virtual {v0, v3}, Landroid/view/MotionEvent;->getX(I)F

    move-result v7

    .line 575
    const/4 v3, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v3}, Landroid/view/MotionEvent;->getY(I)F

    move-result v8

    .line 577
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/adobe/air/wand/view/GestureListener;->mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

    const/4 v6, 0x1

    invoke-virtual/range {v3 .. v13}, Lcom/adobe/air/wand/view/CompanionView;->onGestureListener(IIZFFFFFFF)V

    .line 579
    const/4 v3, 0x0

    move-object/from16 v0, p0

    iput-boolean v3, v0, Lcom/adobe/air/wand/view/GestureListener;->mCheckForSwipe:Z

    goto/16 :goto_4

    .line 551
    :cond_d
    const/high16 v12, -0x40800000    # -1.0f

    goto :goto_5

    .line 554
    :cond_e
    invoke-static/range {v17 .. v17}, Ljava/lang/Math;->abs(F)F

    move-result v3

    const v6, 0x41cb3333    # 25.4f

    mul-float/2addr v3, v6

    sget v6, Lcom/adobe/air/wand/view/GestureListener;->screenPPI:I

    int-to-float v6, v6

    div-float/2addr v3, v6

    const/high16 v6, 0x41200000    # 10.0f

    cmpl-float v3, v3, v6

    if-ltz v3, :cond_10

    invoke-static/range {v16 .. v16}, Ljava/lang/Math;->abs(F)F

    move-result v3

    const v6, 0x41cb3333    # 25.4f

    mul-float/2addr v3, v6

    sget v6, Lcom/adobe/air/wand/view/GestureListener;->screenPPI:I

    int-to-float v6, v6

    div-float/2addr v3, v6

    const/high16 v6, 0x40a00000    # 5.0f

    cmpg-float v3, v3, v6

    if-gtz v3, :cond_10

    .line 556
    const/16 v19, 0x1

    .line 557
    const/4 v12, 0x0

    .line 558
    const/4 v3, 0x0

    cmpl-float v3, v17, v3

    if-lez v3, :cond_f

    const/high16 v13, 0x3f800000    # 1.0f

    :goto_7
    goto :goto_6

    :cond_f
    const/high16 v13, -0x40800000    # -1.0f

    goto :goto_7

    .line 563
    :cond_10
    const/16 v19, 0x0

    goto :goto_6
.end method

.method public onShowPress(Landroid/view/MotionEvent;)V
    .locals 0
    .param p1, "e"    # Landroid/view/MotionEvent;

    .prologue
    .line 613
    return-void
.end method

.method public onSingleTapConfirmed(Landroid/view/MotionEvent;)Z
    .locals 1
    .param p1, "me"    # Landroid/view/MotionEvent;

    .prologue
    .line 654
    const/4 v0, 0x1

    return v0
.end method

.method public onSingleTapUp(Landroid/view/MotionEvent;)Z
    .locals 1
    .param p1, "e"    # Landroid/view/MotionEvent;

    .prologue
    .line 662
    const/4 v0, 0x1

    return v0
.end method

.method public onTwoFingerTap()Z
    .locals 12

    .prologue
    const/4 v3, 0x0

    const/high16 v9, 0x40000000    # 2.0f

    const/high16 v6, 0x3f800000    # 1.0f

    const/4 v8, 0x0

    .line 626
    const/4 v11, 0x1

    .line 628
    .local v11, "retVal":Z
    iget-object v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

    invoke-virtual {v0}, Lcom/adobe/air/wand/view/CompanionView;->getMultitouchMode()I

    move-result v0

    iget-object v7, p0, Lcom/adobe/air/wand/view/GestureListener;->mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

    invoke-virtual {v7}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    const/4 v7, 0x2

    if-eq v0, v7, :cond_0

    .line 646
    :goto_0
    return v11

    .line 631
    :cond_0
    const/16 v1, 0x8

    .line 632
    .local v1, "gesturePhase":I
    const/4 v2, 0x3

    .line 633
    .local v2, "gestureType":I
    const/4 v4, 0x0

    .line 634
    .local v4, "locX":F
    const/4 v5, 0x0

    .line 637
    .local v5, "locY":F
    iget-object v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mSecondaryPointOfTwoFingerTap:Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    invoke-static {v0}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$200(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F

    move-result v0

    iget-object v7, p0, Lcom/adobe/air/wand/view/GestureListener;->mPrimaryPointOfTwoFingerTap:Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    invoke-static {v7}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$200(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F

    move-result v7

    add-float/2addr v0, v7

    div-float v4, v0, v9

    .line 638
    iget-object v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mSecondaryPointOfTwoFingerTap:Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    invoke-static {v0}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$300(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F

    move-result v0

    iget-object v7, p0, Lcom/adobe/air/wand/view/GestureListener;->mPrimaryPointOfTwoFingerTap:Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    invoke-static {v7}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$300(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F

    move-result v7

    add-float/2addr v0, v7

    div-float v5, v0, v9

    .line 641
    iget-object v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mCompanionView:Lcom/adobe/air/wand/view/CompanionView;

    move v7, v6

    move v9, v8

    move v10, v8

    invoke-virtual/range {v0 .. v10}, Lcom/adobe/air/wand/view/CompanionView;->onGestureListener(IIZFFFFFFF)V

    .line 644
    iput v3, p0, Lcom/adobe/air/wand/view/GestureListener;->mCouldBeTwoFingerTap:I

    goto :goto_0
.end method

.method public setCheckForSwipe(Z)V
    .locals 0
    .param p1, "aVal"    # Z

    .prologue
    .line 223
    iput-boolean p1, p0, Lcom/adobe/air/wand/view/GestureListener;->mCheckForSwipe:Z

    .line 224
    return-void
.end method

.method public setCouldBeTwoFingerTap(I)V
    .locals 2
    .param p1, "iVal"    # I

    .prologue
    .line 184
    iput p1, p0, Lcom/adobe/air/wand/view/GestureListener;->mCouldBeTwoFingerTap:I

    .line 186
    if-nez p1, :cond_0

    .line 187
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mTwoFingerTapStartTime:J

    .line 188
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mDidOccurTwoFingerGesture:Z

    .line 190
    :cond_0
    return-void
.end method

.method public setDownTouchPoint(FFI)V
    .locals 1
    .param p1, "x"    # F
    .param p2, "y"    # F
    .param p3, "pid"    # I

    .prologue
    .line 176
    if-ltz p3, :cond_0

    const/4 v0, 0x2

    if-ge p3, v0, :cond_0

    .line 178
    iget-object v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mDownTouchPoints:[Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    aget-object v0, v0, p3

    invoke-static {v0, p1, p2, p3}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->access$000(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;FFI)V

    .line 180
    :cond_0
    return-void
.end method

.method public setPrimaryPointOfTwoFingerTap(FFI)V
    .locals 1
    .param p1, "x"    # F
    .param p2, "y"    # F
    .param p3, "pid"    # I

    .prologue
    .line 204
    new-instance v0, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;-><init>(Lcom/adobe/air/wand/view/GestureListener;FFI)V

    iput-object v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mPrimaryPointOfTwoFingerTap:Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    .line 205
    return-void
.end method

.method public setSecondaryPointOfTwoFingerTap(FFI)V
    .locals 1
    .param p1, "x"    # F
    .param p2, "y"    # F
    .param p3, "pid"    # I

    .prologue
    .line 199
    new-instance v0, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;-><init>(Lcom/adobe/air/wand/view/GestureListener;FFI)V

    iput-object v0, p0, Lcom/adobe/air/wand/view/GestureListener;->mSecondaryPointOfTwoFingerTap:Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    .line 200
    return-void
.end method

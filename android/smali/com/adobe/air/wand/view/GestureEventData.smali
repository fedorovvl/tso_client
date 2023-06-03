.class public Lcom/adobe/air/wand/view/GestureEventData;
.super Ljava/lang/Object;
.source "GestureEventData.java"


# instance fields
.field public mIsTransform:Z

.field public mOffsetX:F

.field public mOffsetY:F

.field public mPhase:I

.field public mRotation:F

.field public mScaleX:F

.field public mScaleY:F

.field public mType:I

.field public mXCoord:F

.field public mYCoord:F


# direct methods
.method public constructor <init>(IIZFFFFFFF)V
    .locals 3
    .param p1, "phase"    # I
    .param p2, "type"    # I
    .param p3, "isTransform"    # Z
    .param p4, "xCoord"    # F
    .param p5, "yCoord"    # F
    .param p6, "scaleX"    # F
    .param p7, "scaleY"    # F
    .param p8, "rotation"    # F
    .param p9, "offsetX"    # F
    .param p10, "offsetY"    # F

    .prologue
    const/high16 v2, 0x3f800000    # 1.0f

    const/4 v1, 0x0

    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 24
    const/4 v0, 0x2

    iput v0, p0, Lcom/adobe/air/wand/view/GestureEventData;->mPhase:I

    .line 25
    const/4 v0, 0x0

    iput v0, p0, Lcom/adobe/air/wand/view/GestureEventData;->mType:I

    .line 26
    iput v1, p0, Lcom/adobe/air/wand/view/GestureEventData;->mXCoord:F

    iput v1, p0, Lcom/adobe/air/wand/view/GestureEventData;->mYCoord:F

    .line 27
    iput v2, p0, Lcom/adobe/air/wand/view/GestureEventData;->mScaleX:F

    iput v2, p0, Lcom/adobe/air/wand/view/GestureEventData;->mScaleY:F

    .line 28
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/adobe/air/wand/view/GestureEventData;->mIsTransform:Z

    .line 29
    iput v1, p0, Lcom/adobe/air/wand/view/GestureEventData;->mRotation:F

    .line 30
    iput v1, p0, Lcom/adobe/air/wand/view/GestureEventData;->mOffsetX:F

    iput v1, p0, Lcom/adobe/air/wand/view/GestureEventData;->mOffsetY:F

    .line 34
    iput p1, p0, Lcom/adobe/air/wand/view/GestureEventData;->mPhase:I

    .line 35
    iput p2, p0, Lcom/adobe/air/wand/view/GestureEventData;->mType:I

    .line 36
    iput-boolean p3, p0, Lcom/adobe/air/wand/view/GestureEventData;->mIsTransform:Z

    .line 37
    iput p4, p0, Lcom/adobe/air/wand/view/GestureEventData;->mXCoord:F

    .line 38
    iput p5, p0, Lcom/adobe/air/wand/view/GestureEventData;->mYCoord:F

    .line 39
    iput p6, p0, Lcom/adobe/air/wand/view/GestureEventData;->mScaleX:F

    .line 40
    iput p7, p0, Lcom/adobe/air/wand/view/GestureEventData;->mScaleY:F

    .line 41
    iput p8, p0, Lcom/adobe/air/wand/view/GestureEventData;->mRotation:F

    .line 42
    iput p9, p0, Lcom/adobe/air/wand/view/GestureEventData;->mOffsetX:F

    .line 43
    iput p10, p0, Lcom/adobe/air/wand/view/GestureEventData;->mOffsetY:F

    .line 44
    return-void
.end method

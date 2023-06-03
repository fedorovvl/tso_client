.class public Lcom/adobe/air/TouchEventData;
.super Ljava/lang/Object;
.source "TouchEventData.java"


# instance fields
.field public mContactX:F

.field public mContactY:F

.field public mHistory:[F

.field public mIsPrimaryPoint:Z

.field public mMetaState:I

.field public mPointerID:I

.field public mPressure:F

.field public mTouchEventType:I

.field public mXCoord:F

.field public mYCoord:F


# direct methods
.method public constructor <init>(IFFFIFFZ[FI)V
    .locals 0
    .param p1, "touchEventType"    # I
    .param p2, "xCoord"    # F
    .param p3, "yCoord"    # F
    .param p4, "pressure"    # F
    .param p5, "pointerID"    # I
    .param p6, "contactX"    # F
    .param p7, "contactY"    # F
    .param p8, "isPrimaryPoint"    # Z
    .param p9, "history"    # [F
    .param p10, "metaState"    # I

    .prologue
    .line 40
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 41
    iput p1, p0, Lcom/adobe/air/TouchEventData;->mTouchEventType:I

    .line 42
    iput p2, p0, Lcom/adobe/air/TouchEventData;->mXCoord:F

    .line 43
    iput p3, p0, Lcom/adobe/air/TouchEventData;->mYCoord:F

    .line 44
    iput p4, p0, Lcom/adobe/air/TouchEventData;->mPressure:F

    .line 45
    iput p5, p0, Lcom/adobe/air/TouchEventData;->mPointerID:I

    .line 46
    iput p6, p0, Lcom/adobe/air/TouchEventData;->mContactX:F

    .line 47
    iput p7, p0, Lcom/adobe/air/TouchEventData;->mContactY:F

    .line 48
    iput-boolean p8, p0, Lcom/adobe/air/TouchEventData;->mIsPrimaryPoint:Z

    .line 49
    iput-object p9, p0, Lcom/adobe/air/TouchEventData;->mHistory:[F

    .line 50
    iput p10, p0, Lcom/adobe/air/TouchEventData;->mMetaState:I

    .line 51
    return-void
.end method

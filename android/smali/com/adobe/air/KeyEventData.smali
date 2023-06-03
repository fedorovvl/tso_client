.class public Lcom/adobe/air/KeyEventData;
.super Ljava/lang/Object;
.source "KeyEventData.java"


# instance fields
.field mAlt:Z

.field mKeyAction:I

.field mKeyCode:I

.field mShift:Z

.field mSym:Z

.field mUnicode:I


# direct methods
.method public constructor <init>(IIIZZZ)V
    .locals 0
    .param p1, "inKeyAction"    # I
    .param p2, "inKeyCode"    # I
    .param p3, "unicode"    # I
    .param p4, "alt"    # Z
    .param p5, "shift"    # Z
    .param p6, "sym"    # Z

    .prologue
    .line 38
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 39
    iput p1, p0, Lcom/adobe/air/KeyEventData;->mKeyAction:I

    .line 40
    iput p2, p0, Lcom/adobe/air/KeyEventData;->mKeyCode:I

    .line 41
    iput p3, p0, Lcom/adobe/air/KeyEventData;->mUnicode:I

    .line 42
    iput-boolean p4, p0, Lcom/adobe/air/KeyEventData;->mAlt:Z

    .line 43
    iput-boolean p5, p0, Lcom/adobe/air/KeyEventData;->mShift:Z

    .line 44
    iput-boolean p6, p0, Lcom/adobe/air/KeyEventData;->mSym:Z

    .line 45
    return-void
.end method

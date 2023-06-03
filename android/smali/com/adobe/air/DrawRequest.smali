.class Lcom/adobe/air/DrawRequest;
.super Ljava/lang/Object;
.source "AIRWindowThreadedSurfaceView.java"


# static fields
.field public static final messageID:I = 0x3f1


# instance fields
.field public bgColor:I

.field public bm:Landroid/graphics/Bitmap;

.field public dstHt:I

.field public dstWd:I

.field public dstX:I

.field public dstY:I

.field public fullsc:Z

.field public ht:I

.field public scale:Z

.field public wd:I

.field public x:I

.field public y:I


# direct methods
.method public constructor <init>(IIIILandroid/graphics/Bitmap;)V
    .locals 1
    .param p1, "_x"    # I
    .param p2, "_y"    # I
    .param p3, "_wd"    # I
    .param p4, "_ht"    # I
    .param p5, "_bm"    # Landroid/graphics/Bitmap;

    .prologue
    const/4 v0, 0x0

    .line 228
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 223
    iput-boolean v0, p0, Lcom/adobe/air/DrawRequest;->scale:Z

    .line 224
    iput-boolean v0, p0, Lcom/adobe/air/DrawRequest;->fullsc:Z

    .line 229
    iput p1, p0, Lcom/adobe/air/DrawRequest;->x:I

    .line 230
    iput p2, p0, Lcom/adobe/air/DrawRequest;->y:I

    .line 231
    iput p3, p0, Lcom/adobe/air/DrawRequest;->wd:I

    .line 232
    iput p4, p0, Lcom/adobe/air/DrawRequest;->ht:I

    .line 233
    iput-object p5, p0, Lcom/adobe/air/DrawRequest;->bm:Landroid/graphics/Bitmap;

    .line 234
    iput-boolean v0, p0, Lcom/adobe/air/DrawRequest;->scale:Z

    .line 235
    return-void
.end method

.method public constructor <init>(IIIILandroid/graphics/Bitmap;IIIIZI)V
    .locals 1
    .param p1, "_x"    # I
    .param p2, "_y"    # I
    .param p3, "_wd"    # I
    .param p4, "_ht"    # I
    .param p5, "_bm"    # Landroid/graphics/Bitmap;
    .param p6, "_dstX"    # I
    .param p7, "_dstY"    # I
    .param p8, "_dstWd"    # I
    .param p9, "_dstHt"    # I
    .param p10, "_fullsc"    # Z
    .param p11, "_bgColor"    # I

    .prologue
    const/4 v0, 0x0

    .line 238
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 223
    iput-boolean v0, p0, Lcom/adobe/air/DrawRequest;->scale:Z

    .line 224
    iput-boolean v0, p0, Lcom/adobe/air/DrawRequest;->fullsc:Z

    .line 239
    iput p1, p0, Lcom/adobe/air/DrawRequest;->x:I

    .line 240
    iput p2, p0, Lcom/adobe/air/DrawRequest;->y:I

    .line 241
    iput p3, p0, Lcom/adobe/air/DrawRequest;->wd:I

    .line 242
    iput p4, p0, Lcom/adobe/air/DrawRequest;->ht:I

    .line 243
    iput-object p5, p0, Lcom/adobe/air/DrawRequest;->bm:Landroid/graphics/Bitmap;

    .line 244
    iput p6, p0, Lcom/adobe/air/DrawRequest;->dstX:I

    .line 245
    iput p7, p0, Lcom/adobe/air/DrawRequest;->dstY:I

    .line 246
    iput p8, p0, Lcom/adobe/air/DrawRequest;->dstWd:I

    .line 247
    iput p9, p0, Lcom/adobe/air/DrawRequest;->dstHt:I

    .line 248
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/adobe/air/DrawRequest;->scale:Z

    .line 249
    iput-boolean p10, p0, Lcom/adobe/air/DrawRequest;->fullsc:Z

    .line 250
    iput p11, p0, Lcom/adobe/air/DrawRequest;->bgColor:I

    .line 251
    return-void
.end method

.class public Lcom/adobe/flashruntime/air/VideoViewAIR;
.super Lcom/adobe/flashruntime/shared/VideoView;
.source "VideoViewAIR.java"


# static fields
.field private static kLogTag:Ljava/lang/String;


# instance fields
.field protected mActivityWrapper:Lcom/adobe/air/AndroidActivityWrapper;

.field private mVideoFlashEGL:Lcom/adobe/air/FlashEGL;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 38
    const-string v0, "VideoViewAIR"

    sput-object v0, Lcom/adobe/flashruntime/air/VideoViewAIR;->kLogTag:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lcom/adobe/air/AndroidActivityWrapper;)V
    .locals 2
    .param p1, "inContext"    # Landroid/content/Context;
    .param p2, "inWrapper"    # Lcom/adobe/air/AndroidActivityWrapper;

    .prologue
    .line 45
    invoke-direct {p0, p1}, Lcom/adobe/flashruntime/shared/VideoView;-><init>(Landroid/content/Context;)V

    .line 40
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/flashruntime/air/VideoViewAIR;->mVideoFlashEGL:Lcom/adobe/air/FlashEGL;

    .line 46
    iput-object p2, p0, Lcom/adobe/flashruntime/air/VideoViewAIR;->mActivityWrapper:Lcom/adobe/air/AndroidActivityWrapper;

    .line 47
    iget-object v0, p0, Lcom/adobe/flashruntime/air/VideoViewAIR;->mActivityWrapper:Lcom/adobe/air/AndroidActivityWrapper;

    const/4 v1, 0x7

    invoke-virtual {v0, p0, v1}, Lcom/adobe/air/AndroidActivityWrapper;->registerPlane(Landroid/view/SurfaceView;I)V

    .line 48
    iget-object v0, p0, Lcom/adobe/flashruntime/air/VideoViewAIR;->mActivityWrapper:Lcom/adobe/air/AndroidActivityWrapper;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidActivityWrapper;->planeStepCascade()V

    .line 55
    invoke-virtual {p0}, Lcom/adobe/flashruntime/air/VideoViewAIR;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v0

    new-instance v1, Lcom/adobe/flashruntime/air/VideoViewAIR$1;

    invoke-direct {v1, p0}, Lcom/adobe/flashruntime/air/VideoViewAIR$1;-><init>(Lcom/adobe/flashruntime/air/VideoViewAIR;)V

    invoke-interface {v0, v1}, Landroid/view/SurfaceHolder;->addCallback(Landroid/view/SurfaceHolder$Callback;)V

    .line 72
    return-void
.end method

.method static synthetic access$000(Lcom/adobe/flashruntime/air/VideoViewAIR;JII)V
    .locals 1
    .param p0, "x0"    # Lcom/adobe/flashruntime/air/VideoViewAIR;
    .param p1, "x1"    # J
    .param p3, "x2"    # I
    .param p4, "x3"    # I

    .prologue
    .line 35
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/adobe/flashruntime/air/VideoViewAIR;->nativeSetSurfaceSize(JII)V

    return-void
.end method

.method private native nativeSetSurfaceSize(JII)V
.end method


# virtual methods
.method public getVideoEgl()Lcom/adobe/air/FlashEGL;
    .locals 1

    .prologue
    .line 77
    iget-object v0, p0, Lcom/adobe/flashruntime/air/VideoViewAIR;->mVideoFlashEGL:Lcom/adobe/air/FlashEGL;

    if-nez v0, :cond_0

    .line 79
    invoke-static {}, Lcom/adobe/air/FlashEGLFactory;->CreateFlashEGL()Lcom/adobe/air/FlashEGL;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/flashruntime/air/VideoViewAIR;->mVideoFlashEGL:Lcom/adobe/air/FlashEGL;

    .line 83
    :cond_0
    iget-object v0, p0, Lcom/adobe/flashruntime/air/VideoViewAIR;->mVideoFlashEGL:Lcom/adobe/air/FlashEGL;

    return-object v0
.end method

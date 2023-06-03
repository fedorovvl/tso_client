.class public Lcom/adobe/flashruntime/shared/VideoView;
.super Landroid/view/SurfaceView;
.source "VideoView.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "VideoSurfaceView"


# instance fields
.field private mAmCreated:Z

.field private mCPPInstance:J

.field private mContext:Landroid/content/Context;

.field private mPlanePositionSet:Z

.field private mSurface:Landroid/view/Surface;

.field private mXmax:I

.field private mXmin:I

.field private mYmax:I

.field private mYmin:I


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/16 v2, 0x10

    const/4 v1, -0x2

    const/4 v0, 0x0

    .line 58
    invoke-direct {p0, p1}, Landroid/view/SurfaceView;-><init>(Landroid/content/Context;)V

    .line 48
    iput v0, p0, Lcom/adobe/flashruntime/shared/VideoView;->mXmin:I

    .line 49
    iput v0, p0, Lcom/adobe/flashruntime/shared/VideoView;->mYmin:I

    .line 50
    iput v2, p0, Lcom/adobe/flashruntime/shared/VideoView;->mXmax:I

    .line 51
    iput v2, p0, Lcom/adobe/flashruntime/shared/VideoView;->mYmax:I

    .line 53
    iput-boolean v0, p0, Lcom/adobe/flashruntime/shared/VideoView;->mAmCreated:Z

    .line 54
    iput-boolean v0, p0, Lcom/adobe/flashruntime/shared/VideoView;->mPlanePositionSet:Z

    .line 55
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/flashruntime/shared/VideoView;->mSurface:Landroid/view/Surface;

    .line 60
    iput-object p1, p0, Lcom/adobe/flashruntime/shared/VideoView;->mContext:Landroid/content/Context;

    .line 63
    new-instance v0, Landroid/view/ViewGroup$LayoutParams;

    invoke-direct {v0, v1, v1}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {p0, v0}, Lcom/adobe/flashruntime/shared/VideoView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 66
    invoke-virtual {p0}, Lcom/adobe/flashruntime/shared/VideoView;->useOverlay()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 67
    invoke-virtual {p0}, Lcom/adobe/flashruntime/shared/VideoView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v0

    const v1, 0x32315659

    invoke-interface {v0, v1}, Landroid/view/SurfaceHolder;->setFormat(I)V

    .line 70
    :cond_0
    invoke-virtual {p0}, Lcom/adobe/flashruntime/shared/VideoView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v0

    new-instance v1, Lcom/adobe/flashruntime/shared/VideoView$1;

    invoke-direct {v1, p0}, Lcom/adobe/flashruntime/shared/VideoView$1;-><init>(Lcom/adobe/flashruntime/shared/VideoView;)V

    invoke-interface {v0, v1}, Landroid/view/SurfaceHolder;->addCallback(Landroid/view/SurfaceHolder$Callback;)V

    .line 102
    return-void
.end method

.method static synthetic access$000(Lcom/adobe/flashruntime/shared/VideoView;)Z
    .locals 1
    .param p0, "x0"    # Lcom/adobe/flashruntime/shared/VideoView;

    .prologue
    .line 44
    iget-boolean v0, p0, Lcom/adobe/flashruntime/shared/VideoView;->mPlanePositionSet:Z

    return v0
.end method

.method static synthetic access$100(Lcom/adobe/flashruntime/shared/VideoView;)I
    .locals 1
    .param p0, "x0"    # Lcom/adobe/flashruntime/shared/VideoView;

    .prologue
    .line 44
    iget v0, p0, Lcom/adobe/flashruntime/shared/VideoView;->mXmax:I

    return v0
.end method

.method static synthetic access$200(Lcom/adobe/flashruntime/shared/VideoView;)I
    .locals 1
    .param p0, "x0"    # Lcom/adobe/flashruntime/shared/VideoView;

    .prologue
    .line 44
    iget v0, p0, Lcom/adobe/flashruntime/shared/VideoView;->mXmin:I

    return v0
.end method

.method static synthetic access$300(Lcom/adobe/flashruntime/shared/VideoView;)I
    .locals 1
    .param p0, "x0"    # Lcom/adobe/flashruntime/shared/VideoView;

    .prologue
    .line 44
    iget v0, p0, Lcom/adobe/flashruntime/shared/VideoView;->mYmax:I

    return v0
.end method

.method static synthetic access$400(Lcom/adobe/flashruntime/shared/VideoView;)I
    .locals 1
    .param p0, "x0"    # Lcom/adobe/flashruntime/shared/VideoView;

    .prologue
    .line 44
    iget v0, p0, Lcom/adobe/flashruntime/shared/VideoView;->mYmin:I

    return v0
.end method

.method static synthetic access$500(Lcom/adobe/flashruntime/shared/VideoView;)Landroid/view/Surface;
    .locals 1
    .param p0, "x0"    # Lcom/adobe/flashruntime/shared/VideoView;

    .prologue
    .line 44
    iget-object v0, p0, Lcom/adobe/flashruntime/shared/VideoView;->mSurface:Landroid/view/Surface;

    return-object v0
.end method

.method static synthetic access$502(Lcom/adobe/flashruntime/shared/VideoView;Landroid/view/Surface;)Landroid/view/Surface;
    .locals 0
    .param p0, "x0"    # Lcom/adobe/flashruntime/shared/VideoView;
    .param p1, "x1"    # Landroid/view/Surface;

    .prologue
    .line 44
    iput-object p1, p0, Lcom/adobe/flashruntime/shared/VideoView;->mSurface:Landroid/view/Surface;

    return-object p1
.end method

.method static synthetic access$602(Lcom/adobe/flashruntime/shared/VideoView;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/adobe/flashruntime/shared/VideoView;
    .param p1, "x1"    # Z

    .prologue
    .line 44
    iput-boolean p1, p0, Lcom/adobe/flashruntime/shared/VideoView;->mAmCreated:Z

    return p1
.end method

.method private native nativeSetJavaViewReady(JZ)V
.end method


# virtual methods
.method public VideoPlaybackRestarted()V
    .locals 0

    .prologue
    .line 109
    return-void
.end method

.method public getFPInstance()J
    .locals 2

    .prologue
    .line 125
    iget-wide v0, p0, Lcom/adobe/flashruntime/shared/VideoView;->mCPPInstance:J

    return-wide v0
.end method

.method public getSurface()Landroid/view/Surface;
    .locals 1

    .prologue
    .line 152
    iget-boolean v0, p0, Lcom/adobe/flashruntime/shared/VideoView;->mAmCreated:Z

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lcom/adobe/flashruntime/shared/VideoView;->useOverlay()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 153
    iget-object v0, p0, Lcom/adobe/flashruntime/shared/VideoView;->mSurface:Landroid/view/Surface;

    .line 155
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public notifyNativeReadyForVideo()V
    .locals 4

    .prologue
    .line 160
    iget-wide v0, p0, Lcom/adobe/flashruntime/shared/VideoView;->mCPPInstance:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    .line 161
    iget-wide v0, p0, Lcom/adobe/flashruntime/shared/VideoView;->mCPPInstance:J

    iget-boolean v2, p0, Lcom/adobe/flashruntime/shared/VideoView;->mAmCreated:Z

    invoke-direct {p0, v0, v1, v2}, Lcom/adobe/flashruntime/shared/VideoView;->nativeSetJavaViewReady(JZ)V

    .line 162
    :cond_0
    return-void
.end method

.method public setFPInstance(J)V
    .locals 5
    .param p1, "inFPInstance"    # J

    .prologue
    .line 118
    const-string v0, "VideoSurfaceView"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Changing FP Instance from "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-wide v2, p0, Lcom/adobe/flashruntime/shared/VideoView;->mCPPInstance:J

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " to "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 119
    iput-wide p1, p0, Lcom/adobe/flashruntime/shared/VideoView;->mCPPInstance:J

    .line 120
    invoke-virtual {p0}, Lcom/adobe/flashruntime/shared/VideoView;->notifyNativeReadyForVideo()V

    .line 121
    return-void
.end method

.method setNativeInstance(J)V
    .locals 0
    .param p1, "instance"    # J

    .prologue
    .line 114
    return-void
.end method

.method public setPlanePosition(IIII)V
    .locals 2
    .param p1, "xmin"    # I
    .param p2, "ymin"    # I
    .param p3, "xmax"    # I
    .param p4, "ymax"    # I

    .prologue
    .line 131
    iput p1, p0, Lcom/adobe/flashruntime/shared/VideoView;->mXmin:I

    iput p2, p0, Lcom/adobe/flashruntime/shared/VideoView;->mYmin:I

    iput p3, p0, Lcom/adobe/flashruntime/shared/VideoView;->mXmax:I

    iput p4, p0, Lcom/adobe/flashruntime/shared/VideoView;->mYmax:I

    .line 132
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/adobe/flashruntime/shared/VideoView;->mPlanePositionSet:Z

    .line 133
    invoke-virtual {p0}, Lcom/adobe/flashruntime/shared/VideoView;->getHandler()Landroid/os/Handler;

    move-result-object v0

    new-instance v1, Lcom/adobe/flashruntime/shared/VideoView$2;

    invoke-direct {v1, p0}, Lcom/adobe/flashruntime/shared/VideoView$2;-><init>(Lcom/adobe/flashruntime/shared/VideoView;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 140
    return-void
.end method

.method protected useOverlay()Z
    .locals 2

    .prologue
    .line 144
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0xe

    if-lt v0, v1, :cond_0

    .line 145
    const/4 v0, 0x1

    .line 147
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

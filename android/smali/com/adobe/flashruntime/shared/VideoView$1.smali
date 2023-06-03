.class Lcom/adobe/flashruntime/shared/VideoView$1;
.super Ljava/lang/Object;
.source "VideoView.java"

# interfaces
.implements Landroid/view/SurfaceHolder$Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/flashruntime/shared/VideoView;-><init>(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/flashruntime/shared/VideoView;


# direct methods
.method constructor <init>(Lcom/adobe/flashruntime/shared/VideoView;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/flashruntime/shared/VideoView;

    .prologue
    .line 70
    iput-object p1, p0, Lcom/adobe/flashruntime/shared/VideoView$1;->this$0:Lcom/adobe/flashruntime/shared/VideoView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public surfaceChanged(Landroid/view/SurfaceHolder;III)V
    .locals 5
    .param p1, "holder"    # Landroid/view/SurfaceHolder;
    .param p2, "format"    # I
    .param p3, "width"    # I
    .param p4, "height"    # I

    .prologue
    .line 72
    const-string v0, "VideoSurfaceView"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "surfaceChanged format="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", width="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", height="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 73
    iget-object v0, p0, Lcom/adobe/flashruntime/shared/VideoView$1;->this$0:Lcom/adobe/flashruntime/shared/VideoView;

    invoke-virtual {v0}, Lcom/adobe/flashruntime/shared/VideoView;->useOverlay()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 79
    iget-object v0, p0, Lcom/adobe/flashruntime/shared/VideoView$1;->this$0:Lcom/adobe/flashruntime/shared/VideoView;

    invoke-static {v0}, Lcom/adobe/flashruntime/shared/VideoView;->access$000(Lcom/adobe/flashruntime/shared/VideoView;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/adobe/flashruntime/shared/VideoView$1;->this$0:Lcom/adobe/flashruntime/shared/VideoView;

    invoke-static {v0}, Lcom/adobe/flashruntime/shared/VideoView;->access$100(Lcom/adobe/flashruntime/shared/VideoView;)I

    move-result v0

    iget-object v1, p0, Lcom/adobe/flashruntime/shared/VideoView$1;->this$0:Lcom/adobe/flashruntime/shared/VideoView;

    invoke-static {v1}, Lcom/adobe/flashruntime/shared/VideoView;->access$200(Lcom/adobe/flashruntime/shared/VideoView;)I

    move-result v1

    sub-int/2addr v0, v1

    if-ne p3, v0, :cond_0

    iget-object v0, p0, Lcom/adobe/flashruntime/shared/VideoView$1;->this$0:Lcom/adobe/flashruntime/shared/VideoView;

    invoke-static {v0}, Lcom/adobe/flashruntime/shared/VideoView;->access$300(Lcom/adobe/flashruntime/shared/VideoView;)I

    move-result v0

    iget-object v1, p0, Lcom/adobe/flashruntime/shared/VideoView$1;->this$0:Lcom/adobe/flashruntime/shared/VideoView;

    invoke-static {v1}, Lcom/adobe/flashruntime/shared/VideoView;->access$400(Lcom/adobe/flashruntime/shared/VideoView;)I

    move-result v1

    sub-int/2addr v0, v1

    if-eq p4, v0, :cond_1

    .line 82
    :cond_0
    iget-object v0, p0, Lcom/adobe/flashruntime/shared/VideoView$1;->this$0:Lcom/adobe/flashruntime/shared/VideoView;

    iget-object v1, p0, Lcom/adobe/flashruntime/shared/VideoView$1;->this$0:Lcom/adobe/flashruntime/shared/VideoView;

    invoke-static {v1}, Lcom/adobe/flashruntime/shared/VideoView;->access$200(Lcom/adobe/flashruntime/shared/VideoView;)I

    move-result v1

    iget-object v2, p0, Lcom/adobe/flashruntime/shared/VideoView$1;->this$0:Lcom/adobe/flashruntime/shared/VideoView;

    invoke-static {v2}, Lcom/adobe/flashruntime/shared/VideoView;->access$400(Lcom/adobe/flashruntime/shared/VideoView;)I

    move-result v2

    iget-object v3, p0, Lcom/adobe/flashruntime/shared/VideoView$1;->this$0:Lcom/adobe/flashruntime/shared/VideoView;

    invoke-static {v3}, Lcom/adobe/flashruntime/shared/VideoView;->access$100(Lcom/adobe/flashruntime/shared/VideoView;)I

    move-result v3

    iget-object v4, p0, Lcom/adobe/flashruntime/shared/VideoView$1;->this$0:Lcom/adobe/flashruntime/shared/VideoView;

    invoke-static {v4}, Lcom/adobe/flashruntime/shared/VideoView;->access$300(Lcom/adobe/flashruntime/shared/VideoView;)I

    move-result v4

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/adobe/flashruntime/shared/VideoView;->setPlanePosition(IIII)V

    .line 86
    :cond_1
    return-void
.end method

.method public surfaceCreated(Landroid/view/SurfaceHolder;)V
    .locals 2
    .param p1, "holder"    # Landroid/view/SurfaceHolder;

    .prologue
    .line 89
    const-string v0, "VideoSurfaceView"

    const-string v1, "surfaceCreated"

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 90
    iget-object v0, p0, Lcom/adobe/flashruntime/shared/VideoView$1;->this$0:Lcom/adobe/flashruntime/shared/VideoView;

    invoke-interface {p1}, Landroid/view/SurfaceHolder;->getSurface()Landroid/view/Surface;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/adobe/flashruntime/shared/VideoView;->access$502(Lcom/adobe/flashruntime/shared/VideoView;Landroid/view/Surface;)Landroid/view/Surface;

    .line 91
    iget-object v0, p0, Lcom/adobe/flashruntime/shared/VideoView$1;->this$0:Lcom/adobe/flashruntime/shared/VideoView;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/adobe/flashruntime/shared/VideoView;->access$602(Lcom/adobe/flashruntime/shared/VideoView;Z)Z

    .line 92
    iget-object v0, p0, Lcom/adobe/flashruntime/shared/VideoView$1;->this$0:Lcom/adobe/flashruntime/shared/VideoView;

    invoke-virtual {v0}, Lcom/adobe/flashruntime/shared/VideoView;->notifyNativeReadyForVideo()V

    .line 93
    return-void
.end method

.method public surfaceDestroyed(Landroid/view/SurfaceHolder;)V
    .locals 2
    .param p1, "holder"    # Landroid/view/SurfaceHolder;

    .prologue
    .line 96
    const-string v0, "VideoSurfaceView"

    const-string v1, "surfaceDestroyed"

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 97
    iget-object v0, p0, Lcom/adobe/flashruntime/shared/VideoView$1;->this$0:Lcom/adobe/flashruntime/shared/VideoView;

    invoke-static {v0}, Lcom/adobe/flashruntime/shared/VideoView;->access$500(Lcom/adobe/flashruntime/shared/VideoView;)Landroid/view/Surface;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Surface;->release()V

    .line 98
    iget-object v0, p0, Lcom/adobe/flashruntime/shared/VideoView$1;->this$0:Lcom/adobe/flashruntime/shared/VideoView;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/adobe/flashruntime/shared/VideoView;->access$602(Lcom/adobe/flashruntime/shared/VideoView;Z)Z

    .line 99
    iget-object v0, p0, Lcom/adobe/flashruntime/shared/VideoView$1;->this$0:Lcom/adobe/flashruntime/shared/VideoView;

    invoke-virtual {v0}, Lcom/adobe/flashruntime/shared/VideoView;->notifyNativeReadyForVideo()V

    .line 100
    return-void
.end method

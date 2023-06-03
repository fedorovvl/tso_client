.class Lcom/adobe/flashruntime/air/VideoViewAIR$1;
.super Ljava/lang/Object;
.source "VideoViewAIR.java"

# interfaces
.implements Landroid/view/SurfaceHolder$Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/flashruntime/air/VideoViewAIR;-><init>(Landroid/content/Context;Lcom/adobe/air/AndroidActivityWrapper;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/flashruntime/air/VideoViewAIR;


# direct methods
.method constructor <init>(Lcom/adobe/flashruntime/air/VideoViewAIR;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/flashruntime/air/VideoViewAIR;

    .prologue
    .line 55
    iput-object p1, p0, Lcom/adobe/flashruntime/air/VideoViewAIR$1;->this$0:Lcom/adobe/flashruntime/air/VideoViewAIR;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public surfaceChanged(Landroid/view/SurfaceHolder;III)V
    .locals 4
    .param p1, "holder"    # Landroid/view/SurfaceHolder;
    .param p2, "format"    # I
    .param p3, "width"    # I
    .param p4, "height"    # I

    .prologue
    .line 58
    iget-object v0, p0, Lcom/adobe/flashruntime/air/VideoViewAIR$1;->this$0:Lcom/adobe/flashruntime/air/VideoViewAIR;

    iget-object v1, p0, Lcom/adobe/flashruntime/air/VideoViewAIR$1;->this$0:Lcom/adobe/flashruntime/air/VideoViewAIR;

    invoke-virtual {v1}, Lcom/adobe/flashruntime/air/VideoViewAIR;->getFPInstance()J

    move-result-wide v2

    invoke-static {v0, v2, v3, p3, p4}, Lcom/adobe/flashruntime/air/VideoViewAIR;->access$000(Lcom/adobe/flashruntime/air/VideoViewAIR;JII)V

    .line 60
    return-void
.end method

.method public surfaceCreated(Landroid/view/SurfaceHolder;)V
    .locals 1
    .param p1, "holder"    # Landroid/view/SurfaceHolder;

    .prologue
    .line 64
    iget-object v0, p0, Lcom/adobe/flashruntime/air/VideoViewAIR$1;->this$0:Lcom/adobe/flashruntime/air/VideoViewAIR;

    iget-object v0, v0, Lcom/adobe/flashruntime/air/VideoViewAIR;->mActivityWrapper:Lcom/adobe/air/AndroidActivityWrapper;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidActivityWrapper;->planeStepCascade()V

    .line 65
    return-void
.end method

.method public surfaceDestroyed(Landroid/view/SurfaceHolder;)V
    .locals 1
    .param p1, "holder"    # Landroid/view/SurfaceHolder;

    .prologue
    .line 69
    iget-object v0, p0, Lcom/adobe/flashruntime/air/VideoViewAIR$1;->this$0:Lcom/adobe/flashruntime/air/VideoViewAIR;

    iget-object v0, v0, Lcom/adobe/flashruntime/air/VideoViewAIR;->mActivityWrapper:Lcom/adobe/air/AndroidActivityWrapper;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidActivityWrapper;->planeBreakCascade()V

    .line 70
    return-void
.end method

.class Lcom/adobe/air/AndroidCameraView;
.super Landroid/view/SurfaceView;
.source "AndroidCamera.java"

# interfaces
.implements Landroid/view/SurfaceHolder$Callback;


# instance fields
.field private mActivityWrapper:Lcom/adobe/air/AndroidActivityWrapper;

.field private mRecreating:Z


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/adobe/air/AndroidActivityWrapper;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "wrapper"    # Lcom/adobe/air/AndroidActivityWrapper;

    .prologue
    const/4 v2, 0x0

    .line 53
    invoke-direct {p0, p1}, Landroid/view/SurfaceView;-><init>(Landroid/content/Context;)V

    .line 44
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/AndroidCameraView;->mActivityWrapper:Lcom/adobe/air/AndroidActivityWrapper;

    .line 49
    iput-boolean v2, p0, Lcom/adobe/air/AndroidCameraView;->mRecreating:Z

    .line 54
    iput-object p2, p0, Lcom/adobe/air/AndroidCameraView;->mActivityWrapper:Lcom/adobe/air/AndroidActivityWrapper;

    .line 55
    invoke-virtual {p0}, Lcom/adobe/air/AndroidCameraView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v0

    const/4 v1, 0x3

    invoke-interface {v0, v1}, Landroid/view/SurfaceHolder;->setType(I)V

    .line 56
    invoke-virtual {p0, v2}, Lcom/adobe/air/AndroidCameraView;->setZOrderMediaOverlay(Z)V

    .line 58
    invoke-virtual {p0}, Lcom/adobe/air/AndroidCameraView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v0

    invoke-interface {v0, p0}, Landroid/view/SurfaceHolder;->addCallback(Landroid/view/SurfaceHolder$Callback;)V

    .line 59
    return-void
.end method


# virtual methods
.method public surfaceChanged(Landroid/view/SurfaceHolder;III)V
    .locals 0
    .param p1, "holder"    # Landroid/view/SurfaceHolder;
    .param p2, "format"    # I
    .param p3, "width"    # I
    .param p4, "height"    # I

    .prologue
    .line 62
    return-void
.end method

.method public surfaceCreated(Landroid/view/SurfaceHolder;)V
    .locals 1
    .param p1, "holder"    # Landroid/view/SurfaceHolder;

    .prologue
    .line 65
    iget-object v0, p0, Lcom/adobe/air/AndroidCameraView;->mActivityWrapper:Lcom/adobe/air/AndroidActivityWrapper;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidActivityWrapper;->planeStepCascade()V

    .line 66
    return-void
.end method

.method public surfaceDestroyed(Landroid/view/SurfaceHolder;)V
    .locals 1
    .param p1, "holder"    # Landroid/view/SurfaceHolder;

    .prologue
    .line 69
    iget-object v0, p0, Lcom/adobe/air/AndroidCameraView;->mActivityWrapper:Lcom/adobe/air/AndroidActivityWrapper;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidActivityWrapper;->planeBreakCascade()V

    .line 70
    return-void
.end method

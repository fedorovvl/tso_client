.class Lcom/adobe/air/AIRWindowSurfaceView$InputMethodReceiver;
.super Landroid/os/ResultReceiver;
.source "AIRWindowSurfaceView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/AIRWindowSurfaceView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "InputMethodReceiver"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/AIRWindowSurfaceView;


# direct methods
.method public constructor <init>(Lcom/adobe/air/AIRWindowSurfaceView;)V
    .locals 1
    .param p1, "this$0"    # Lcom/adobe/air/AIRWindowSurfaceView;

    .prologue
    .line 897
    iput-object p1, p0, Lcom/adobe/air/AIRWindowSurfaceView$InputMethodReceiver;->this$0:Lcom/adobe/air/AIRWindowSurfaceView;

    .line 898
    invoke-virtual {p1}, Lcom/adobe/air/AIRWindowSurfaceView;->getHandler()Landroid/os/Handler;

    move-result-object v0

    invoke-direct {p0, v0}, Landroid/os/ResultReceiver;-><init>(Landroid/os/Handler;)V

    .line 899
    return-void
.end method


# virtual methods
.method protected onReceiveResult(ILandroid/os/Bundle;)V
    .locals 2
    .param p1, "resultCode"    # I
    .param p2, "resultData"    # Landroid/os/Bundle;

    .prologue
    const/4 v1, 0x1

    .line 904
    if-eq p1, v1, :cond_0

    const/4 v0, 0x3

    if-ne p1, v0, :cond_1

    .line 908
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/AIRWindowSurfaceView$InputMethodReceiver;->this$0:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v0}, Lcom/adobe/air/AIRWindowSurfaceView;->nativeShowOriginalRect()V

    .line 914
    :goto_0
    return-void

    .line 912
    :cond_1
    iget-object v0, p0, Lcom/adobe/air/AIRWindowSurfaceView$InputMethodReceiver;->this$0:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-static {v0, v1}, Lcom/adobe/air/AIRWindowSurfaceView;->access$500(Lcom/adobe/air/AIRWindowSurfaceView;Z)V

    goto :goto_0
.end method

.class Lcom/adobe/air/DrawThread$1;
.super Landroid/os/Handler;
.source "AIRWindowThreadedSurfaceView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/DrawThread;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/DrawThread;


# direct methods
.method constructor <init>(Lcom/adobe/air/DrawThread;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/DrawThread;

    .prologue
    .line 152
    iput-object p1, p0, Lcom/adobe/air/DrawThread$1;->this$0:Lcom/adobe/air/DrawThread;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 2
    .param p1, "m"    # Landroid/os/Message;

    .prologue
    .line 156
    iget v0, p1, Landroid/os/Message;->what:I

    const/16 v1, 0x3f1

    if-ne v0, v1, :cond_0

    .line 158
    iget-object v1, p0, Lcom/adobe/air/DrawThread$1;->this$0:Lcom/adobe/air/DrawThread;

    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Lcom/adobe/air/DrawRequest;

    invoke-static {v1, v0}, Lcom/adobe/air/DrawThread;->access$000(Lcom/adobe/air/DrawThread;Lcom/adobe/air/DrawRequest;)V

    .line 162
    iget-object v0, p0, Lcom/adobe/air/DrawThread$1;->this$0:Lcom/adobe/air/DrawThread;

    invoke-static {v0}, Lcom/adobe/air/DrawThread;->access$100(Lcom/adobe/air/DrawThread;)Lcom/adobe/air/AIRWindowThreadedSurfaceView;

    move-result-object v0

    iget-object v0, v0, Lcom/adobe/air/AIRWindowThreadedSurfaceView;->drawSemaphore:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 164
    :cond_0
    return-void
.end method

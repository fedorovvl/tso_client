.class Lcom/adobe/air/wand/WandManager$TaskListener;
.super Ljava/lang/Object;
.source "WandManager.java"

# interfaces
.implements Lcom/adobe/air/wand/TaskManager$Listener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/wand/WandManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "TaskListener"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/wand/WandManager;


# direct methods
.method private constructor <init>(Lcom/adobe/air/wand/WandManager;)V
    .locals 0

    .prologue
    .line 186
    iput-object p1, p0, Lcom/adobe/air/wand/WandManager$TaskListener;->this$0:Lcom/adobe/air/wand/WandManager;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/adobe/air/wand/WandManager;Lcom/adobe/air/wand/WandManager$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/adobe/air/wand/WandManager;
    .param p2, "x1"    # Lcom/adobe/air/wand/WandManager$1;

    .prologue
    .line 186
    invoke-direct {p0, p1}, Lcom/adobe/air/wand/WandManager$TaskListener;-><init>(Lcom/adobe/air/wand/WandManager;)V

    return-void
.end method


# virtual methods
.method public drawImage(Landroid/graphics/Bitmap;)V
    .locals 1
    .param p1, "image"    # Landroid/graphics/Bitmap;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 215
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager$TaskListener;->this$0:Lcom/adobe/air/wand/WandManager;

    invoke-static {v0}, Lcom/adobe/air/wand/WandManager;->access$100(Lcom/adobe/air/wand/WandManager;)Lcom/adobe/air/wand/view/WandView;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/adobe/air/wand/view/WandView;->drawImage(Landroid/graphics/Bitmap;)V

    .line 216
    return-void
.end method

.method public getRequestedProtocolVerison()Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 221
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager$TaskListener;->this$0:Lcom/adobe/air/wand/WandManager;

    invoke-static {v0}, Lcom/adobe/air/wand/WandManager;->access$000(Lcom/adobe/air/wand/WandManager;)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/Exception;

    const-string v1, "No active connection."

    invoke-direct {v0, v1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw v0

    .line 223
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager$TaskListener;->this$0:Lcom/adobe/air/wand/WandManager;

    invoke-static {v0}, Lcom/adobe/air/wand/WandManager;->access$000(Lcom/adobe/air/wand/WandManager;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public sendConnectionMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 195
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager$TaskListener;->this$0:Lcom/adobe/air/wand/WandManager;

    invoke-static {v0}, Lcom/adobe/air/wand/WandManager;->access$400(Lcom/adobe/air/wand/WandManager;)Lcom/adobe/air/wand/connection/Connection;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/adobe/air/wand/connection/Connection;->send(Ljava/lang/String;)V

    .line 196
    return-void
.end method

.method public setScreenOrientation(Lcom/adobe/air/wand/view/WandView$ScreenOrientation;)V
    .locals 1
    .param p1, "orientation"    # Lcom/adobe/air/wand/view/WandView$ScreenOrientation;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 206
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager$TaskListener;->this$0:Lcom/adobe/air/wand/WandManager;

    invoke-static {v0}, Lcom/adobe/air/wand/WandManager;->access$100(Lcom/adobe/air/wand/WandManager;)Lcom/adobe/air/wand/view/WandView;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/adobe/air/wand/view/WandView;->setScreenOrientation(Lcom/adobe/air/wand/view/WandView$ScreenOrientation;)V

    .line 207
    return-void
.end method

.class Lcom/adobe/air/wand/WandManager$ViewListener;
.super Ljava/lang/Object;
.source "WandManager.java"

# interfaces
.implements Lcom/adobe/air/wand/view/WandView$Listener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/wand/WandManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "ViewListener"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/wand/WandManager;


# direct methods
.method private constructor <init>(Lcom/adobe/air/wand/WandManager;)V
    .locals 0

    .prologue
    .line 154
    iput-object p1, p0, Lcom/adobe/air/wand/WandManager$ViewListener;->this$0:Lcom/adobe/air/wand/WandManager;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/adobe/air/wand/WandManager;Lcom/adobe/air/wand/WandManager$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/adobe/air/wand/WandManager;
    .param p2, "x1"    # Lcom/adobe/air/wand/WandManager$1;

    .prologue
    .line 154
    invoke-direct {p0, p1}, Lcom/adobe/air/wand/WandManager$ViewListener;-><init>(Lcom/adobe/air/wand/WandManager;)V

    return-void
.end method


# virtual methods
.method public getConnectionToken()Ljava/lang/String;
    .locals 2

    .prologue
    .line 167
    :try_start_0
    iget-object v1, p0, Lcom/adobe/air/wand/WandManager$ViewListener;->this$0:Lcom/adobe/air/wand/WandManager;

    invoke-static {v1}, Lcom/adobe/air/wand/WandManager;->access$400(Lcom/adobe/air/wand/WandManager;)Lcom/adobe/air/wand/connection/Connection;

    move-result-object v1

    invoke-interface {v1}, Lcom/adobe/air/wand/connection/Connection;->getConnectionToken()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 171
    :goto_0
    return-object v1

    .line 169
    :catch_0
    move-exception v0

    .line 171
    .local v0, "e":Ljava/lang/Exception;
    const-string v1, ""

    goto :goto_0
.end method

.method public onLoadCompanion(Landroid/content/res/Configuration;)V
    .locals 2
    .param p1, "currentConfiguration"    # Landroid/content/res/Configuration;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 178
    iget v0, p1, Landroid/content/res/Configuration;->orientation:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/adobe/air/wand/WandManager$ViewListener;->this$0:Lcom/adobe/air/wand/WandManager;

    invoke-static {v0}, Lcom/adobe/air/wand/WandManager;->access$400(Lcom/adobe/air/wand/WandManager;)Lcom/adobe/air/wand/connection/Connection;

    move-result-object v0

    invoke-interface {v0}, Lcom/adobe/air/wand/connection/Connection;->onReadyForConnection()V

    .line 180
    :goto_0
    return-void

    .line 179
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager$ViewListener;->this$0:Lcom/adobe/air/wand/WandManager;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/adobe/air/wand/WandManager;->access$502(Lcom/adobe/air/wand/WandManager;Z)Z

    goto :goto_0
.end method

.class Lcom/adobe/air/wand/WandManager$ConnectionListener;
.super Ljava/lang/Object;
.source "WandManager.java"

# interfaces
.implements Lcom/adobe/air/wand/connection/Connection$Listener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/wand/WandManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "ConnectionListener"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/wand/WandManager;


# direct methods
.method private constructor <init>(Lcom/adobe/air/wand/WandManager;)V
    .locals 0

    .prologue
    .line 54
    iput-object p1, p0, Lcom/adobe/air/wand/WandManager$ConnectionListener;->this$0:Lcom/adobe/air/wand/WandManager;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/adobe/air/wand/WandManager;Lcom/adobe/air/wand/WandManager$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/adobe/air/wand/WandManager;
    .param p2, "x1"    # Lcom/adobe/air/wand/WandManager$1;

    .prologue
    .line 54
    invoke-direct {p0, p1}, Lcom/adobe/air/wand/WandManager$ConnectionListener;-><init>(Lcom/adobe/air/wand/WandManager;)V

    return-void
.end method


# virtual methods
.method public onConnectError()V
    .locals 0

    .prologue
    .line 113
    return-void
.end method

.method public onConnectSuccess()V
    .locals 0

    .prologue
    .line 106
    return-void
.end method

.method public onConnectionClose()V
    .locals 2

    .prologue
    .line 88
    :try_start_0
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager$ConnectionListener;->this$0:Lcom/adobe/air/wand/WandManager;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/adobe/air/wand/WandManager;->access$002(Lcom/adobe/air/wand/WandManager;Ljava/lang/String;)Ljava/lang/String;

    .line 93
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager$ConnectionListener;->this$0:Lcom/adobe/air/wand/WandManager;

    invoke-static {v0}, Lcom/adobe/air/wand/WandManager;->access$200(Lcom/adobe/air/wand/WandManager;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 99
    :goto_0
    return-void

    .line 95
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public onConnectionOpen(Ljava/lang/String;)V
    .locals 2
    .param p1, "protocolVersion"    # Ljava/lang/String;

    .prologue
    .line 64
    :try_start_0
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager$ConnectionListener;->this$0:Lcom/adobe/air/wand/WandManager;

    invoke-static {v0, p1}, Lcom/adobe/air/wand/WandManager;->access$002(Lcom/adobe/air/wand/WandManager;Ljava/lang/String;)Ljava/lang/String;

    .line 70
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager$ConnectionListener;->this$0:Lcom/adobe/air/wand/WandManager;

    invoke-static {v0}, Lcom/adobe/air/wand/WandManager;->access$100(Lcom/adobe/air/wand/WandManager;)Lcom/adobe/air/wand/view/WandView;

    move-result-object v0

    sget-object v1, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->LANDSCAPE:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    invoke-interface {v0, v1}, Lcom/adobe/air/wand/view/WandView;->setScreenOrientation(Lcom/adobe/air/wand/view/WandView$ScreenOrientation;)V

    .line 71
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager$ConnectionListener;->this$0:Lcom/adobe/air/wand/WandManager;

    invoke-static {v0}, Lcom/adobe/air/wand/WandManager;->access$100(Lcom/adobe/air/wand/WandManager;)Lcom/adobe/air/wand/view/WandView;

    move-result-object v0

    invoke-interface {v0}, Lcom/adobe/air/wand/view/WandView;->loadCompanionView()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 78
    :goto_0
    return-void

    .line 73
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public onDisconnectError()V
    .locals 0

    .prologue
    .line 128
    return-void
.end method

.method public onDisconnectSuccess()V
    .locals 0

    .prologue
    .line 120
    return-void
.end method

.method public onReceive(Ljava/lang/String;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;

    .prologue
    .line 137
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager$ConnectionListener;->this$0:Lcom/adobe/air/wand/WandManager;

    invoke-static {v0}, Lcom/adobe/air/wand/WandManager;->access$300(Lcom/adobe/air/wand/WandManager;)Lcom/adobe/air/wand/TaskManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/adobe/air/wand/TaskManager;->handleRemoteMessage(Ljava/lang/String;)V

    .line 138
    return-void
.end method

.method public updateConnectionToken(Ljava/lang/String;)V
    .locals 1
    .param p1, "connectionToken"    # Ljava/lang/String;

    .prologue
    .line 147
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager$ConnectionListener;->this$0:Lcom/adobe/air/wand/WandManager;

    invoke-static {v0}, Lcom/adobe/air/wand/WandManager;->access$100(Lcom/adobe/air/wand/WandManager;)Lcom/adobe/air/wand/view/WandView;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/adobe/air/wand/view/WandView;->updateConnectionToken(Ljava/lang/String;)V

    .line 148
    return-void
.end method

.class Lcom/adobe/air/wand/connection/WandWebSocket$WandSocketServer$1;
.super Ljava/util/TimerTask;
.source "WandWebSocket.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/wand/connection/WandWebSocket$WandSocketServer;->scheduleHandshakeTimer()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/adobe/air/wand/connection/WandWebSocket$WandSocketServer;


# direct methods
.method constructor <init>(Lcom/adobe/air/wand/connection/WandWebSocket$WandSocketServer;)V
    .locals 0
    .param p1, "this$1"    # Lcom/adobe/air/wand/connection/WandWebSocket$WandSocketServer;

    .prologue
    .line 319
    iput-object p1, p0, Lcom/adobe/air/wand/connection/WandWebSocket$WandSocketServer$1;->this$1:Lcom/adobe/air/wand/connection/WandWebSocket$WandSocketServer;

    invoke-direct {p0}, Ljava/util/TimerTask;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 324
    const-string v1, "OPEN_SYNCHRONIZER"

    monitor-enter v1

    .line 326
    :try_start_0
    iget-object v0, p0, Lcom/adobe/air/wand/connection/WandWebSocket$WandSocketServer$1;->this$1:Lcom/adobe/air/wand/connection/WandWebSocket$WandSocketServer;

    iget-object v0, v0, Lcom/adobe/air/wand/connection/WandWebSocket$WandSocketServer;->this$0:Lcom/adobe/air/wand/connection/WandWebSocket;

    invoke-static {v0}, Lcom/adobe/air/wand/connection/WandWebSocket;->access$100(Lcom/adobe/air/wand/connection/WandWebSocket;)Lorg/java_websocket/WebSocket;

    move-result-object v0

    if-nez v0, :cond_0

    .line 327
    monitor-exit v1

    .line 338
    :goto_0
    return-void

    .line 329
    :cond_0
    const-string v2, "HANDSHAKE_SYNCHRONIZER"

    monitor-enter v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 331
    :try_start_1
    iget-object v0, p0, Lcom/adobe/air/wand/connection/WandWebSocket$WandSocketServer$1;->this$1:Lcom/adobe/air/wand/connection/WandWebSocket$WandSocketServer;

    iget-object v0, v0, Lcom/adobe/air/wand/connection/WandWebSocket$WandSocketServer;->this$0:Lcom/adobe/air/wand/connection/WandWebSocket;

    invoke-static {v0}, Lcom/adobe/air/wand/connection/WandWebSocket;->access$500(Lcom/adobe/air/wand/connection/WandWebSocket;)Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 332
    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    :try_start_2
    monitor-exit v1

    goto :goto_0

    .line 334
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0

    .line 333
    :cond_1
    :try_start_3
    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 334
    :try_start_4
    monitor-exit v1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 337
    iget-object v0, p0, Lcom/adobe/air/wand/connection/WandWebSocket$WandSocketServer$1;->this$1:Lcom/adobe/air/wand/connection/WandWebSocket$WandSocketServer;

    iget-object v0, v0, Lcom/adobe/air/wand/connection/WandWebSocket$WandSocketServer;->this$0:Lcom/adobe/air/wand/connection/WandWebSocket;

    invoke-static {v0}, Lcom/adobe/air/wand/connection/WandWebSocket;->access$100(Lcom/adobe/air/wand/connection/WandWebSocket;)Lorg/java_websocket/WebSocket;

    move-result-object v0

    const/16 v1, 0x3eb

    const-string v2, "AIR Gamepad handshake timedout"

    invoke-interface {v0, v1, v2}, Lorg/java_websocket/WebSocket;->close(ILjava/lang/String;)V

    goto :goto_0

    .line 333
    :catchall_1
    move-exception v0

    :try_start_5
    monitor-exit v2
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    :try_start_6
    throw v0
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0
.end method

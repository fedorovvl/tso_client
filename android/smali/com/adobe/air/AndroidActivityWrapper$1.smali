.class Lcom/adobe/air/AndroidActivityWrapper$1;
.super Ljava/lang/Object;
.source "AndroidActivityWrapper.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/AndroidActivityWrapper;->showDialogWaitingForConnection(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/AndroidActivityWrapper;

.field final synthetic val$aDebuggerPort:I


# direct methods
.method constructor <init>(Lcom/adobe/air/AndroidActivityWrapper;I)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/AndroidActivityWrapper;

    .prologue
    .line 1834
    iput-object p1, p0, Lcom/adobe/air/AndroidActivityWrapper$1;->this$0:Lcom/adobe/air/AndroidActivityWrapper;

    iput p2, p0, Lcom/adobe/air/AndroidActivityWrapper$1;->val$aDebuggerPort:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 1839
    const-wide/16 v0, 0x7530

    :try_start_0
    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V

    .line 1840
    new-instance v0, Ljava/net/Socket;

    invoke-static {}, Ljava/net/InetAddress;->getLocalHost()Ljava/net/InetAddress;

    move-result-object v1

    iget v2, p0, Lcom/adobe/air/AndroidActivityWrapper$1;->val$aDebuggerPort:I

    invoke-direct {v0, v1, v2}, Ljava/net/Socket;-><init>(Ljava/net/InetAddress;I)V

    invoke-virtual {v0}, Ljava/net/Socket;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1843
    :goto_0
    return-void

    .line 1842
    :catch_0
    move-exception v0

    goto :goto_0
.end method

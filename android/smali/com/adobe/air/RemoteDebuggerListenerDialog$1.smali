.class Lcom/adobe/air/RemoteDebuggerListenerDialog$1;
.super Landroid/content/BroadcastReceiver;
.source "RemoteDebuggerListenerDialog.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/RemoteDebuggerListenerDialog;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/RemoteDebuggerListenerDialog;


# direct methods
.method constructor <init>(Lcom/adobe/air/RemoteDebuggerListenerDialog;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/RemoteDebuggerListenerDialog;

    .prologue
    .line 71
    iput-object p1, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog$1;->this$0:Lcom/adobe/air/RemoteDebuggerListenerDialog;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    .line 75
    invoke-virtual {p0}, Lcom/adobe/air/RemoteDebuggerListenerDialog$1;->isInitialStickyBroadcast()Z

    move-result v2

    if-nez v2, :cond_0

    .line 78
    iget-object v2, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog$1;->this$0:Lcom/adobe/air/RemoteDebuggerListenerDialog;

    invoke-virtual {v2}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->getIntent()Landroid/content/Intent;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v1

    .line 79
    .local v1, "extras":Landroid/os/Bundle;
    if-eqz v1, :cond_1

    const-string v2, "debuggerPort"

    invoke-virtual {v1, v2}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    .line 81
    .local v0, "dPort":I
    :goto_0
    iget-object v2, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog$1;->this$0:Lcom/adobe/air/RemoteDebuggerListenerDialog;

    invoke-static {v2}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->access$000(Lcom/adobe/air/RemoteDebuggerListenerDialog;)I

    move-result v2

    if-ne v0, v2, :cond_0

    .line 82
    iget-object v2, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog$1;->this$0:Lcom/adobe/air/RemoteDebuggerListenerDialog;

    invoke-static {v2}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->access$100(Lcom/adobe/air/RemoteDebuggerListenerDialog;)V

    .line 84
    .end local v0    # "dPort":I
    .end local v1    # "extras":Landroid/os/Bundle;
    :cond_0
    return-void

    .line 79
    .restart local v1    # "extras":Landroid/os/Bundle;
    :cond_1
    const/16 v0, 0x1f00

    goto :goto_0
.end method

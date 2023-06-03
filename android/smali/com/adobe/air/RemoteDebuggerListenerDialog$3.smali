.class Lcom/adobe/air/RemoteDebuggerListenerDialog$3;
.super Ljava/lang/Object;
.source "RemoteDebuggerListenerDialog.java"

# interfaces
.implements Landroid/content/DialogInterface$OnKeyListener;


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
    .line 104
    iput-object p1, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog$3;->this$0:Lcom/adobe/air/RemoteDebuggerListenerDialog;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onKey(Landroid/content/DialogInterface;ILandroid/view/KeyEvent;)Z
    .locals 2
    .param p1, "dialog"    # Landroid/content/DialogInterface;
    .param p2, "keyCode"    # I
    .param p3, "event"    # Landroid/view/KeyEvent;

    .prologue
    .line 106
    const/4 v0, 0x4

    if-ne p2, v0, :cond_0

    .line 107
    iget-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog$3;->this$0:Lcom/adobe/air/RemoteDebuggerListenerDialog;

    invoke-static {v0}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->access$300(Lcom/adobe/air/RemoteDebuggerListenerDialog;)Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog$3;->this$0:Lcom/adobe/air/RemoteDebuggerListenerDialog;

    invoke-static {v1}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->access$200(Lcom/adobe/air/RemoteDebuggerListenerDialog;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 108
    iget-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog$3;->this$0:Lcom/adobe/air/RemoteDebuggerListenerDialog;

    invoke-static {v0}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->access$400(Lcom/adobe/air/RemoteDebuggerListenerDialog;)V

    .line 109
    iget-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog$3;->this$0:Lcom/adobe/air/RemoteDebuggerListenerDialog;

    iget-object v1, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog$3;->this$0:Lcom/adobe/air/RemoteDebuggerListenerDialog;

    invoke-static {v1}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->access$500(Lcom/adobe/air/RemoteDebuggerListenerDialog;)Landroid/content/BroadcastReceiver;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 110
    iget-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog$3;->this$0:Lcom/adobe/air/RemoteDebuggerListenerDialog;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->access$502(Lcom/adobe/air/RemoteDebuggerListenerDialog;Landroid/content/BroadcastReceiver;)Landroid/content/BroadcastReceiver;

    .line 111
    invoke-interface {p1}, Landroid/content/DialogInterface;->cancel()V

    .line 112
    iget-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog$3;->this$0:Lcom/adobe/air/RemoteDebuggerListenerDialog;

    invoke-virtual {v0}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->finish()V

    .line 115
    :cond_0
    const/4 v0, 0x0

    return v0
.end method

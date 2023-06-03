.class Lcom/adobe/air/RemoteDebuggerListenerDialog$2;
.super Ljava/lang/Object;
.source "RemoteDebuggerListenerDialog.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


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
    .line 94
    iput-object p1, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog$2;->this$0:Lcom/adobe/air/RemoteDebuggerListenerDialog;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2
    .param p1, "dialog"    # Landroid/content/DialogInterface;
    .param p2, "whichButton"    # I

    .prologue
    .line 96
    iget-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog$2;->this$0:Lcom/adobe/air/RemoteDebuggerListenerDialog;

    invoke-static {v0}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->access$300(Lcom/adobe/air/RemoteDebuggerListenerDialog;)Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog$2;->this$0:Lcom/adobe/air/RemoteDebuggerListenerDialog;

    invoke-static {v1}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->access$200(Lcom/adobe/air/RemoteDebuggerListenerDialog;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 97
    iget-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog$2;->this$0:Lcom/adobe/air/RemoteDebuggerListenerDialog;

    invoke-static {v0}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->access$400(Lcom/adobe/air/RemoteDebuggerListenerDialog;)V

    .line 98
    iget-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog$2;->this$0:Lcom/adobe/air/RemoteDebuggerListenerDialog;

    iget-object v1, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog$2;->this$0:Lcom/adobe/air/RemoteDebuggerListenerDialog;

    invoke-static {v1}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->access$500(Lcom/adobe/air/RemoteDebuggerListenerDialog;)Landroid/content/BroadcastReceiver;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 99
    iget-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog$2;->this$0:Lcom/adobe/air/RemoteDebuggerListenerDialog;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->access$502(Lcom/adobe/air/RemoteDebuggerListenerDialog;Landroid/content/BroadcastReceiver;)Landroid/content/BroadcastReceiver;

    .line 100
    invoke-interface {p1}, Landroid/content/DialogInterface;->cancel()V

    .line 101
    iget-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog$2;->this$0:Lcom/adobe/air/RemoteDebuggerListenerDialog;

    invoke-virtual {v0}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->finish()V

    .line 102
    return-void
.end method

.class Lcom/adobe/air/RemoteDebuggerListenerDialog$4$1;
.super Ljava/lang/Object;
.source "RemoteDebuggerListenerDialog.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/RemoteDebuggerListenerDialog$4;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/adobe/air/RemoteDebuggerListenerDialog$4;


# direct methods
.method constructor <init>(Lcom/adobe/air/RemoteDebuggerListenerDialog$4;)V
    .locals 0
    .param p1, "this$1"    # Lcom/adobe/air/RemoteDebuggerListenerDialog$4;

    .prologue
    .line 142
    iput-object p1, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog$4$1;->this$1:Lcom/adobe/air/RemoteDebuggerListenerDialog$4;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 1
    .param p1, "dialog"    # Landroid/content/DialogInterface;
    .param p2, "whichButton"    # I

    .prologue
    .line 144
    iget-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog$4$1;->this$1:Lcom/adobe/air/RemoteDebuggerListenerDialog$4;

    iget-object v0, v0, Lcom/adobe/air/RemoteDebuggerListenerDialog$4;->this$0:Lcom/adobe/air/RemoteDebuggerListenerDialog;

    invoke-static {v0}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->access$400(Lcom/adobe/air/RemoteDebuggerListenerDialog;)V

    .line 145
    invoke-interface {p1}, Landroid/content/DialogInterface;->cancel()V

    .line 146
    iget-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog$4$1;->this$1:Lcom/adobe/air/RemoteDebuggerListenerDialog$4;

    iget-object v0, v0, Lcom/adobe/air/RemoteDebuggerListenerDialog$4;->this$0:Lcom/adobe/air/RemoteDebuggerListenerDialog;

    invoke-virtual {v0}, Lcom/adobe/air/RemoteDebuggerListenerDialog;->finish()V

    .line 147
    return-void
.end method

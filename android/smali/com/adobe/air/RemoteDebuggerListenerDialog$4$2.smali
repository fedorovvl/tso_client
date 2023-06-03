.class Lcom/adobe/air/RemoteDebuggerListenerDialog$4$2;
.super Ljava/lang/Object;
.source "RemoteDebuggerListenerDialog.java"

# interfaces
.implements Landroid/content/DialogInterface$OnKeyListener;


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

.field final synthetic val$dialogButtonHandler:Landroid/content/DialogInterface$OnClickListener;


# direct methods
.method constructor <init>(Lcom/adobe/air/RemoteDebuggerListenerDialog$4;Landroid/content/DialogInterface$OnClickListener;)V
    .locals 0
    .param p1, "this$1"    # Lcom/adobe/air/RemoteDebuggerListenerDialog$4;

    .prologue
    .line 154
    iput-object p1, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog$4$2;->this$1:Lcom/adobe/air/RemoteDebuggerListenerDialog$4;

    iput-object p2, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog$4$2;->val$dialogButtonHandler:Landroid/content/DialogInterface$OnClickListener;

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
    .line 156
    const/4 v0, 0x4

    if-ne p2, v0, :cond_0

    .line 157
    iget-object v0, p0, Lcom/adobe/air/RemoteDebuggerListenerDialog$4$2;->val$dialogButtonHandler:Landroid/content/DialogInterface$OnClickListener;

    const/4 v1, -0x1

    invoke-interface {v0, p1, v1}, Landroid/content/DialogInterface$OnClickListener;->onClick(Landroid/content/DialogInterface;I)V

    .line 159
    :cond_0
    const/4 v0, 0x0

    return v0
.end method

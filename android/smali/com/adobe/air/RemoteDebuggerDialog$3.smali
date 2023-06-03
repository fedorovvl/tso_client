.class Lcom/adobe/air/RemoteDebuggerDialog$3;
.super Ljava/lang/Object;
.source "RemoteDebuggerDialog.java"

# interfaces
.implements Landroid/content/DialogInterface$OnCancelListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/RemoteDebuggerDialog;->createAndShowDialog(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/RemoteDebuggerDialog;


# direct methods
.method constructor <init>(Lcom/adobe/air/RemoteDebuggerDialog;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/RemoteDebuggerDialog;

    .prologue
    .line 91
    iput-object p1, p0, Lcom/adobe/air/RemoteDebuggerDialog$3;->this$0:Lcom/adobe/air/RemoteDebuggerDialog;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCancel(Landroid/content/DialogInterface;)V
    .locals 3
    .param p1, "dialog"    # Landroid/content/DialogInterface;

    .prologue
    .line 94
    iget-object v0, p0, Lcom/adobe/air/RemoteDebuggerDialog$3;->this$0:Lcom/adobe/air/RemoteDebuggerDialog;

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lcom/adobe/air/RemoteDebuggerDialog;->gotResultFromDialog(ZLjava/lang/String;)V

    .line 96
    return-void
.end method

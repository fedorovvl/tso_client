.class Lcom/adobe/air/RemoteDebuggerDialog$1;
.super Ljava/lang/Object;
.source "RemoteDebuggerDialog.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


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

.field final synthetic val$pTextinput:Landroid/widget/EditText;


# direct methods
.method constructor <init>(Lcom/adobe/air/RemoteDebuggerDialog;Landroid/widget/EditText;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/RemoteDebuggerDialog;

    .prologue
    .line 74
    iput-object p1, p0, Lcom/adobe/air/RemoteDebuggerDialog$1;->this$0:Lcom/adobe/air/RemoteDebuggerDialog;

    iput-object p2, p0, Lcom/adobe/air/RemoteDebuggerDialog$1;->val$pTextinput:Landroid/widget/EditText;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 3
    .param p1, "dialog"    # Landroid/content/DialogInterface;
    .param p2, "whichButton"    # I

    .prologue
    .line 77
    iget-object v1, p0, Lcom/adobe/air/RemoteDebuggerDialog$1;->val$pTextinput:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    .line 78
    .local v0, "ipOrHost":Ljava/lang/String;
    iget-object v1, p0, Lcom/adobe/air/RemoteDebuggerDialog$1;->this$0:Lcom/adobe/air/RemoteDebuggerDialog;

    const/4 v2, 0x1

    invoke-virtual {v1, v2, v0}, Lcom/adobe/air/RemoteDebuggerDialog;->gotResultFromDialog(ZLjava/lang/String;)V

    .line 80
    return-void
.end method

.class Lcom/adobe/air/ListenErrorDialog$2;
.super Ljava/lang/Object;
.source "ListenErrorDialog.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/ListenErrorDialog;->createAndShowDialog()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/ListenErrorDialog;


# direct methods
.method constructor <init>(Lcom/adobe/air/ListenErrorDialog;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/ListenErrorDialog;

    .prologue
    .line 74
    iput-object p1, p0, Lcom/adobe/air/ListenErrorDialog$2;->this$0:Lcom/adobe/air/ListenErrorDialog;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2
    .param p1, "dialog"    # Landroid/content/DialogInterface;
    .param p2, "whichButton"    # I

    .prologue
    .line 77
    iget-object v0, p0, Lcom/adobe/air/ListenErrorDialog$2;->this$0:Lcom/adobe/air/ListenErrorDialog;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/adobe/air/ListenErrorDialog;->gotResultFromDialog(Z)V

    .line 78
    return-void
.end method

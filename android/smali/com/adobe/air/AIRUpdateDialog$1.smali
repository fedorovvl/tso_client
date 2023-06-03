.class Lcom/adobe/air/AIRUpdateDialog$1;
.super Ljava/lang/Object;
.source "AIRUpdateDialog.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/AIRUpdateDialog;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/AIRUpdateDialog;


# direct methods
.method constructor <init>(Lcom/adobe/air/AIRUpdateDialog;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/AIRUpdateDialog;

    .prologue
    .line 26
    iput-object p1, p0, Lcom/adobe/air/AIRUpdateDialog$1;->this$0:Lcom/adobe/air/AIRUpdateDialog;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 5
    .param p1, "dialog"    # Landroid/content/DialogInterface;
    .param p2, "which"    # I

    .prologue
    const/4 v4, 0x1

    .line 30
    iget-object v1, p0, Lcom/adobe/air/AIRUpdateDialog$1;->this$0:Lcom/adobe/air/AIRUpdateDialog;

    invoke-virtual {v1}, Lcom/adobe/air/AIRUpdateDialog;->getIntent()Landroid/content/Intent;

    move-result-object v1

    const-string v2, "airDownloadURL"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 31
    .local v0, "airDownloadURL":Ljava/lang/String;
    iget-object v1, p0, Lcom/adobe/air/AIRUpdateDialog$1;->this$0:Lcom/adobe/air/AIRUpdateDialog;

    invoke-static {v1}, Lcom/adobe/air/AIRUpdateDialog;->access$000(Lcom/adobe/air/AIRUpdateDialog;)Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/adobe/air/AndroidActivityWrapper;->LaunchMarketPlaceForAIR(Ljava/lang/String;)V

    .line 32
    invoke-static {}, Lcom/adobe/air/AIRUpdateDialog;->access$100()Lcom/adobe/air/AIRUpdateDialog;

    move-result-object v1

    invoke-static {}, Lcom/adobe/air/AIRUpdateDialog;->access$200()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    invoke-static {v1, v2, v4, v4, v3}, Lcom/adobe/air/InstallOfferPingUtils;->PingAndExit(Landroid/app/Activity;Ljava/lang/String;ZZZ)V

    .line 33
    return-void
.end method

.class Lcom/adobe/air/SSLSecurityDialog$5;
.super Ljava/lang/Object;
.source "SSLSecurityDialog.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/SSLSecurityDialog;->ShowSSLDialog(Ljava/lang/String;[BLandroid/net/http/SslCertificate;Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/SSLSecurityDialog;

.field final synthetic val$dialog:Lcom/adobe/air/AndroidAlertDialog;


# direct methods
.method constructor <init>(Lcom/adobe/air/SSLSecurityDialog;Lcom/adobe/air/AndroidAlertDialog;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/SSLSecurityDialog;

    .prologue
    .line 164
    iput-object p1, p0, Lcom/adobe/air/SSLSecurityDialog$5;->this$0:Lcom/adobe/air/SSLSecurityDialog;

    iput-object p2, p0, Lcom/adobe/air/SSLSecurityDialog$5;->val$dialog:Lcom/adobe/air/AndroidAlertDialog;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .prologue
    .line 167
    iget-object v0, p0, Lcom/adobe/air/SSLSecurityDialog$5;->val$dialog:Lcom/adobe/air/AndroidAlertDialog;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidAlertDialog;->show()V

    .line 169
    iget-object v0, p0, Lcom/adobe/air/SSLSecurityDialog$5;->val$dialog:Lcom/adobe/air/AndroidAlertDialog;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidAlertDialog;->setFullScreen()V

    .line 170
    return-void
.end method

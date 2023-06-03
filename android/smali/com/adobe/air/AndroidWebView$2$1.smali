.class Lcom/adobe/air/AndroidWebView$2$1;
.super Ljava/lang/Thread;
.source "AndroidWebView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/AndroidWebView$2;->onReceivedSslError(Landroid/webkit/WebView;Landroid/webkit/SslErrorHandler;Landroid/net/http/SslError;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/adobe/air/AndroidWebView$2;

.field final synthetic val$error:Landroid/net/http/SslError;

.field final synthetic val$handler:Landroid/webkit/SslErrorHandler;

.field final synthetic val$url:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/adobe/air/AndroidWebView$2;Landroid/net/http/SslError;Ljava/lang/String;Landroid/webkit/SslErrorHandler;)V
    .locals 0
    .param p1, "this$1"    # Lcom/adobe/air/AndroidWebView$2;

    .prologue
    .line 533
    iput-object p1, p0, Lcom/adobe/air/AndroidWebView$2$1;->this$1:Lcom/adobe/air/AndroidWebView$2;

    iput-object p2, p0, Lcom/adobe/air/AndroidWebView$2$1;->val$error:Landroid/net/http/SslError;

    iput-object p3, p0, Lcom/adobe/air/AndroidWebView$2$1;->val$url:Ljava/lang/String;

    iput-object p4, p0, Lcom/adobe/air/AndroidWebView$2$1;->val$handler:Landroid/webkit/SslErrorHandler;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .prologue
    .line 535
    const/4 v1, 0x0

    .line 537
    .local v1, "proceed":Z
    iget-object v3, p0, Lcom/adobe/air/AndroidWebView$2$1;->val$error:Landroid/net/http/SslError;

    invoke-virtual {v3}, Landroid/net/http/SslError;->getCertificate()Landroid/net/http/SslCertificate;

    move-result-object v3

    if-eqz v3, :cond_0

    .line 538
    new-instance v2, Lcom/adobe/air/SSLSecurityDialog;

    invoke-direct {v2}, Lcom/adobe/air/SSLSecurityDialog;-><init>()V

    .line 539
    .local v2, "securityDialog":Lcom/adobe/air/SSLSecurityDialog;
    iget-object v3, p0, Lcom/adobe/air/AndroidWebView$2$1;->val$url:Ljava/lang/String;

    iget-object v4, p0, Lcom/adobe/air/AndroidWebView$2$1;->val$error:Landroid/net/http/SslError;

    invoke-virtual {v4}, Landroid/net/http/SslError;->getCertificate()Landroid/net/http/SslCertificate;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Lcom/adobe/air/SSLSecurityDialog;->show(Ljava/lang/String;Landroid/net/http/SslCertificate;)Ljava/lang/String;

    .line 540
    invoke-virtual {v2}, Lcom/adobe/air/SSLSecurityDialog;->getUserAction()Ljava/lang/String;

    move-result-object v0

    .line 542
    .local v0, "action":Ljava/lang/String;
    const-string v3, "session"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 543
    const/4 v1, 0x1

    .line 546
    .end local v0    # "action":Ljava/lang/String;
    .end local v2    # "securityDialog":Lcom/adobe/air/SSLSecurityDialog;
    :cond_0
    if-eqz v1, :cond_1

    .line 547
    iget-object v3, p0, Lcom/adobe/air/AndroidWebView$2$1;->val$handler:Landroid/webkit/SslErrorHandler;

    invoke-virtual {v3}, Landroid/webkit/SslErrorHandler;->proceed()V

    .line 550
    :goto_0
    return-void

    .line 549
    :cond_1
    iget-object v3, p0, Lcom/adobe/air/AndroidWebView$2$1;->val$handler:Landroid/webkit/SslErrorHandler;

    invoke-virtual {v3}, Landroid/webkit/SslErrorHandler;->cancel()V

    goto :goto_0
.end method

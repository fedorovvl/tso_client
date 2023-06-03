.class Lcom/adobe/air/AdobeAIRWebView$1;
.super Landroid/webkit/WebViewClient;
.source "AdobeAIRWebView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/AdobeAIRWebView;->create()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/AdobeAIRWebView;


# direct methods
.method constructor <init>(Lcom/adobe/air/AdobeAIRWebView;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/AdobeAIRWebView;

    .prologue
    .line 44
    iput-object p1, p0, Lcom/adobe/air/AdobeAIRWebView$1;->this$0:Lcom/adobe/air/AdobeAIRWebView;

    invoke-direct {p0}, Landroid/webkit/WebViewClient;-><init>()V

    return-void
.end method


# virtual methods
.method public onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V
    .locals 2
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;

    .prologue
    .line 105
    iget-object v0, p0, Lcom/adobe/air/AdobeAIRWebView$1;->this$0:Lcom/adobe/air/AdobeAIRWebView;

    invoke-static {v0}, Lcom/adobe/air/AdobeAIRWebView;->access$200(Lcom/adobe/air/AdobeAIRWebView;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 107
    const-string v0, "https://www.adobe.com/airgames/4/"

    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 111
    iget-object v0, p0, Lcom/adobe/air/AdobeAIRWebView$1;->this$0:Lcom/adobe/air/AdobeAIRWebView;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/adobe/air/AdobeAIRWebView;->access$202(Lcom/adobe/air/AdobeAIRWebView;Z)Z

    .line 114
    iget-object v0, p0, Lcom/adobe/air/AdobeAIRWebView$1;->this$0:Lcom/adobe/air/AdobeAIRWebView;

    invoke-static {v0}, Lcom/adobe/air/AdobeAIRWebView;->access$000(Lcom/adobe/air/AdobeAIRWebView;)Landroid/content/Context;

    move-result-object v0

    check-cast v0, Landroid/app/Activity;

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Landroid/app/Activity;->setRequestedOrientation(I)V

    .line 118
    iget-object v0, p0, Lcom/adobe/air/AdobeAIRWebView$1;->this$0:Lcom/adobe/air/AdobeAIRWebView;

    invoke-static {v0}, Lcom/adobe/air/AdobeAIRWebView;->access$000(Lcom/adobe/air/AdobeAIRWebView;)Landroid/content/Context;

    move-result-object v0

    check-cast v0, Landroid/app/Activity;

    iget-object v1, p0, Lcom/adobe/air/AdobeAIRWebView$1;->this$0:Lcom/adobe/air/AdobeAIRWebView;

    invoke-static {v1}, Lcom/adobe/air/AdobeAIRWebView;->access$300(Lcom/adobe/air/AdobeAIRWebView;)Landroid/webkit/WebView;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/Activity;->setContentView(Landroid/view/View;)V

    .line 121
    :cond_0
    return-void
.end method

.method public onReceivedError(Landroid/webkit/WebView;ILjava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "errorCode"    # I
    .param p3, "description"    # Ljava/lang/String;
    .param p4, "failingUrl"    # Ljava/lang/String;

    .prologue
    .line 129
    iget-object v0, p0, Lcom/adobe/air/AdobeAIRWebView$1;->this$0:Lcom/adobe/air/AdobeAIRWebView;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/adobe/air/AdobeAIRWebView;->access$402(Lcom/adobe/air/AdobeAIRWebView;Z)Z

    .line 132
    iget-object v0, p0, Lcom/adobe/air/AdobeAIRWebView$1;->this$0:Lcom/adobe/air/AdobeAIRWebView;

    invoke-static {v0}, Lcom/adobe/air/AdobeAIRWebView;->access$300(Lcom/adobe/air/AdobeAIRWebView;)Landroid/webkit/WebView;

    move-result-object v0

    const-string v1, "file:///android_res/raw/startga.html"

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    .line 133
    return-void
.end method

.method public shouldOverrideUrlLoading(Landroid/webkit/WebView;Ljava/lang/String;)Z
    .locals 5
    .param p1, "webView"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;

    .prologue
    .line 50
    if-eqz p2, :cond_5

    .line 52
    invoke-static {p2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    .line 53
    .local v2, "uri":Landroid/net/Uri;
    if-eqz v2, :cond_5

    invoke-virtual {v2}, Landroid/net/Uri;->getScheme()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_5

    .line 58
    const/4 v1, 0x0

    .line 59
    .local v1, "openInBrowser":Z
    :try_start_0
    invoke-virtual {v2}, Landroid/net/Uri;->getHost()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    invoke-virtual {v2}, Landroid/net/Uri;->getScheme()Ljava/lang/String;

    move-result-object v3

    const-string v4, "http"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_0

    invoke-virtual {v2}, Landroid/net/Uri;->getScheme()Ljava/lang/String;

    move-result-object v3

    const-string v4, "https"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_6

    .line 61
    :cond_0
    const-string v3, "https://www.adobe.com/airgames/4/"

    invoke-virtual {p2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1

    invoke-virtual {v2}, Landroid/net/Uri;->getHost()Ljava/lang/String;

    move-result-object v3

    const-string v4, "gamespace.adobe.com"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_1

    invoke-virtual {v2}, Landroid/net/Uri;->getHost()Ljava/lang/String;

    move-result-object v3

    const-string v4, "dh8vjmvwgc27o.cloudfront.net"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 64
    :cond_1
    const/4 v3, 0x0

    .line 98
    .end local v1    # "openInBrowser":Z
    .end local v2    # "uri":Landroid/net/Uri;
    :goto_0
    return v3

    .line 66
    .restart local v1    # "openInBrowser":Z
    .restart local v2    # "uri":Landroid/net/Uri;
    :cond_2
    invoke-virtual {v2}, Landroid/net/Uri;->getHost()Ljava/lang/String;

    move-result-object v3

    const-string v4, "www.adobe.com"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_3

    invoke-virtual {v2}, Landroid/net/Uri;->getHost()Ljava/lang/String;

    move-result-object v3

    const-string v4, "play.google.com"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_3

    invoke-virtual {v2}, Landroid/net/Uri;->getHost()Ljava/lang/String;

    move-result-object v3

    const-string v4, "gaming.adobe.com"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 68
    :cond_3
    const/4 v1, 0x1

    .line 78
    :cond_4
    :goto_1
    if-eqz v1, :cond_7

    .line 80
    new-instance v0, Landroid/content/Intent;

    const-string v3, "android.intent.action.VIEW"

    invoke-direct {v0, v3, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    .line 81
    .local v0, "intent":Landroid/content/Intent;
    iget-object v3, p0, Lcom/adobe/air/AdobeAIRWebView$1;->this$0:Lcom/adobe/air/AdobeAIRWebView;

    invoke-static {v3}, Lcom/adobe/air/AdobeAIRWebView;->access$000(Lcom/adobe/air/AdobeAIRWebView;)Landroid/content/Context;

    move-result-object v3

    check-cast v3, Landroid/app/Activity;

    invoke-virtual {v3, v0}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V

    .line 98
    .end local v0    # "intent":Landroid/content/Intent;
    .end local v1    # "openInBrowser":Z
    .end local v2    # "uri":Landroid/net/Uri;
    :cond_5
    :goto_2
    const/4 v3, 0x1

    goto :goto_0

    .line 74
    .restart local v1    # "openInBrowser":Z
    .restart local v2    # "uri":Landroid/net/Uri;
    :cond_6
    const/4 v1, 0x1

    goto :goto_1

    .line 87
    :cond_7
    iget-object v3, p0, Lcom/adobe/air/AdobeAIRWebView$1;->this$0:Lcom/adobe/air/AdobeAIRWebView;

    invoke-static {v3}, Lcom/adobe/air/AdobeAIRWebView;->access$100(Lcom/adobe/air/AdobeAIRWebView;)Landroid/webkit/WebView;

    move-result-object v3

    invoke-virtual {v3, p2}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    .line 90
    :catch_0
    move-exception v3

    goto :goto_2
.end method

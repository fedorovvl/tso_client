.class Lcom/adobe/air/AdobeAIRWebView$2;
.super Landroid/webkit/WebViewClient;
.source "AdobeAIRWebView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/AdobeAIRWebView;->createAnalyticsWebView()V
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
    .line 180
    iput-object p1, p0, Lcom/adobe/air/AdobeAIRWebView$2;->this$0:Lcom/adobe/air/AdobeAIRWebView;

    invoke-direct {p0}, Landroid/webkit/WebViewClient;-><init>()V

    return-void
.end method


# virtual methods
.method public shouldOverrideUrlLoading(Landroid/webkit/WebView;Ljava/lang/String;)Z
    .locals 1
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;

    .prologue
    .line 184
    const/4 v0, 0x0

    return v0
.end method

.class public Lcom/adobe/air/AndroidWebView$WebViewCustomView;
.super Ljava/lang/Object;
.source "AndroidWebView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/AndroidWebView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "WebViewCustomView"
.end annotation


# instance fields
.field private mCallback:Landroid/webkit/WebChromeClient$CustomViewCallback;

.field private mCustomViewHolder:Landroid/widget/FrameLayout;

.field final synthetic this$0:Lcom/adobe/air/AndroidWebView;


# direct methods
.method public constructor <init>(Lcom/adobe/air/AndroidWebView;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/AndroidWebView;

    .prologue
    .line 76
    iput-object p1, p0, Lcom/adobe/air/AndroidWebView$WebViewCustomView;->this$0:Lcom/adobe/air/AndroidWebView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 77
    return-void
.end method


# virtual methods
.method public onHideCustomView()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    const/4 v3, 0x0

    .line 133
    iget-object v2, p0, Lcom/adobe/air/AndroidWebView$WebViewCustomView;->mCallback:Landroid/webkit/WebChromeClient$CustomViewCallback;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/adobe/air/AndroidWebView$WebViewCustomView;->mCustomViewHolder:Landroid/widget/FrameLayout;

    if-nez v2, :cond_1

    .line 149
    :cond_0
    :goto_0
    return-void

    .line 137
    :cond_1
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v2

    invoke-virtual {v2}, Lcom/adobe/air/AndroidActivityWrapper;->getView()Landroid/view/View;

    move-result-object v0

    .line 138
    .local v0, "mainView":Landroid/view/View;
    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    .line 140
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v2

    invoke-virtual {v2, v3}, Lcom/adobe/air/AndroidActivityWrapper;->getOverlaysLayout(Z)Landroid/widget/RelativeLayout;

    move-result-object v1

    .line 141
    .local v1, "overlaysView":Landroid/view/View;
    if-eqz v1, :cond_2

    .line 142
    invoke-virtual {v1, v3}, Landroid/view/View;->setVisibility(I)V

    .line 144
    :cond_2
    iget-object v2, p0, Lcom/adobe/air/AndroidWebView$WebViewCustomView;->mCustomViewHolder:Landroid/widget/FrameLayout;

    invoke-virtual {v2}, Landroid/widget/FrameLayout;->getParent()Landroid/view/ViewParent;

    move-result-object v2

    check-cast v2, Landroid/view/ViewGroup;

    iget-object v3, p0, Lcom/adobe/air/AndroidWebView$WebViewCustomView;->mCustomViewHolder:Landroid/widget/FrameLayout;

    invoke-virtual {v2, v3}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    .line 145
    iput-object v4, p0, Lcom/adobe/air/AndroidWebView$WebViewCustomView;->mCustomViewHolder:Landroid/widget/FrameLayout;

    .line 147
    iget-object v2, p0, Lcom/adobe/air/AndroidWebView$WebViewCustomView;->mCallback:Landroid/webkit/WebChromeClient$CustomViewCallback;

    invoke-interface {v2}, Landroid/webkit/WebChromeClient$CustomViewCallback;->onCustomViewHidden()V

    .line 148
    iput-object v4, p0, Lcom/adobe/air/AndroidWebView$WebViewCustomView;->mCallback:Landroid/webkit/WebChromeClient$CustomViewCallback;

    goto :goto_0
.end method

.method public onShowCustomView(Landroid/view/View;Landroid/webkit/WebChromeClient$CustomViewCallback;)V
    .locals 8
    .param p1, "view"    # Landroid/view/View;
    .param p2, "callback"    # Landroid/webkit/WebChromeClient$CustomViewCallback;

    .prologue
    const/16 v7, 0x8

    const/4 v6, -0x1

    .line 81
    iget-object v4, p0, Lcom/adobe/air/AndroidWebView$WebViewCustomView;->mCallback:Landroid/webkit/WebChromeClient$CustomViewCallback;

    if-eqz v4, :cond_0

    .line 84
    invoke-interface {p2}, Landroid/webkit/WebChromeClient$CustomViewCallback;->onCustomViewHidden()V

    .line 127
    :goto_0
    return-void

    .line 88
    :cond_0
    iput-object p2, p0, Lcom/adobe/air/AndroidWebView$WebViewCustomView;->mCallback:Landroid/webkit/WebChromeClient$CustomViewCallback;

    .line 91
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v4

    invoke-virtual {v4}, Lcom/adobe/air/AndroidActivityWrapper;->getView()Landroid/view/View;

    move-result-object v2

    .line 92
    .local v2, "mainView":Landroid/view/View;
    invoke-virtual {v2, v7}, Landroid/view/View;->setVisibility(I)V

    .line 94
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v4

    const/4 v5, 0x0

    invoke-virtual {v4, v5}, Lcom/adobe/air/AndroidActivityWrapper;->getOverlaysLayout(Z)Landroid/widget/RelativeLayout;

    move-result-object v3

    .line 95
    .local v3, "overlaysView":Landroid/view/View;
    if-eqz v3, :cond_1

    .line 96
    invoke-virtual {v3, v7}, Landroid/view/View;->setVisibility(I)V

    .line 98
    :cond_1
    new-instance v4, Lcom/adobe/air/AndroidWebView$WebViewCustomView$1;

    iget-object v5, p0, Lcom/adobe/air/AndroidWebView$WebViewCustomView;->this$0:Lcom/adobe/air/AndroidWebView;

    invoke-static {v5}, Lcom/adobe/air/AndroidWebView;->access$000(Lcom/adobe/air/AndroidWebView;)Landroid/content/Context;

    move-result-object v5

    invoke-direct {v4, p0, v5}, Lcom/adobe/air/AndroidWebView$WebViewCustomView$1;-><init>(Lcom/adobe/air/AndroidWebView$WebViewCustomView;Landroid/content/Context;)V

    iput-object v4, p0, Lcom/adobe/air/AndroidWebView$WebViewCustomView;->mCustomViewHolder:Landroid/widget/FrameLayout;

    .line 114
    iget-object v4, p0, Lcom/adobe/air/AndroidWebView$WebViewCustomView;->mCustomViewHolder:Landroid/widget/FrameLayout;

    const/high16 v5, -0x1000000

    invoke-virtual {v4, v5}, Landroid/widget/FrameLayout;->setBackgroundColor(I)V

    .line 115
    new-instance v1, Landroid/widget/FrameLayout$LayoutParams;

    invoke-direct {v1, v6, v6}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    .line 116
    .local v1, "layoutParams":Landroid/widget/FrameLayout$LayoutParams;
    invoke-virtual {v2}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v4

    check-cast v4, Landroid/view/ViewGroup;

    iget-object v5, p0, Lcom/adobe/air/AndroidWebView$WebViewCustomView;->mCustomViewHolder:Landroid/widget/FrameLayout;

    invoke-virtual {v4, v5, v1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 118
    new-instance v0, Landroid/widget/FrameLayout$LayoutParams;

    const/16 v4, 0x11

    invoke-direct {v0, v6, v6, v4}, Landroid/widget/FrameLayout$LayoutParams;-><init>(III)V

    .line 123
    .local v0, "customViewParams":Landroid/widget/FrameLayout$LayoutParams;
    iget-object v4, p0, Lcom/adobe/air/AndroidWebView$WebViewCustomView;->mCustomViewHolder:Landroid/widget/FrameLayout;

    invoke-virtual {v4, p1, v0}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 124
    iget-object v4, p0, Lcom/adobe/air/AndroidWebView$WebViewCustomView;->mCustomViewHolder:Landroid/widget/FrameLayout;

    invoke-virtual {v4}, Landroid/widget/FrameLayout;->bringToFront()V

    .line 126
    iget-object v4, p0, Lcom/adobe/air/AndroidWebView$WebViewCustomView;->mCustomViewHolder:Landroid/widget/FrameLayout;

    invoke-virtual {v4}, Landroid/widget/FrameLayout;->requestFocus()Z

    goto :goto_0
.end method

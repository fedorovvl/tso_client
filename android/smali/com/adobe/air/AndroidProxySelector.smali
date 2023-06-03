.class public final Lcom/adobe/air/AndroidProxySelector;
.super Ljava/lang/Object;
.source "AndroidProxySelector.java"


# static fields
.field private static final LIST_HEAD:I = 0x0

.field private static final LOG_TAG:Ljava/lang/String; = "AndroidProxySelector"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getProxyUrl(Ljava/lang/String;)Ljava/lang/String;
    .locals 6
    .param p0, "urlToConnect"    # Ljava/lang/String;

    .prologue
    .line 53
    :try_start_0
    new-instance v3, Ljava/net/URI;

    invoke-direct {v3, p0}, Ljava/net/URI;-><init>(Ljava/lang/String;)V

    .line 57
    .local v3, "serverUri":Ljava/net/URI;
    invoke-static {}, Ljava/net/ProxySelector;->getDefault()Ljava/net/ProxySelector;

    move-result-object v0

    .line 58
    .local v0, "defaultProxySelector":Ljava/net/ProxySelector;
    invoke-virtual {v0, v3}, Ljava/net/ProxySelector;->select(Ljava/net/URI;)Ljava/util/List;

    move-result-object v1

    .line 60
    .local v1, "proxyServers":Ljava/util/List;, "Ljava/util/List<Ljava/net/Proxy;>;"
    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v4

    if-eqz v4, :cond_0

    .line 62
    const-string v4, ""

    .line 88
    .end local v0    # "defaultProxySelector":Ljava/net/ProxySelector;
    .end local v1    # "proxyServers":Ljava/util/List;, "Ljava/util/List<Ljava/net/Proxy;>;"
    .end local v3    # "serverUri":Ljava/net/URI;
    :goto_0
    return-object v4

    .line 66
    .restart local v0    # "defaultProxySelector":Ljava/net/ProxySelector;
    .restart local v1    # "proxyServers":Ljava/util/List;, "Ljava/util/List<Ljava/net/Proxy;>;"
    .restart local v3    # "serverUri":Ljava/net/URI;
    :cond_0
    const/4 v4, 0x0

    invoke-interface {v1, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/net/Proxy;

    .line 68
    .local v2, "proxyUrl":Ljava/net/Proxy;
    sget-object v4, Ljava/net/Proxy;->NO_PROXY:Ljava/net/Proxy;
    :try_end_0
    .catch Ljava/net/URISyntaxException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_0

    if-ne v4, v2, :cond_2

    .line 88
    .end local v0    # "defaultProxySelector":Ljava/net/ProxySelector;
    .end local v1    # "proxyServers":Ljava/util/List;, "Ljava/util/List<Ljava/net/Proxy;>;"
    .end local v2    # "proxyUrl":Ljava/net/Proxy;
    .end local v3    # "serverUri":Ljava/net/URI;
    :cond_1
    :goto_1
    const-string v4, ""

    goto :goto_0

    .line 75
    .restart local v0    # "defaultProxySelector":Ljava/net/ProxySelector;
    .restart local v1    # "proxyServers":Ljava/util/List;, "Ljava/util/List<Ljava/net/Proxy;>;"
    .restart local v2    # "proxyUrl":Ljava/net/Proxy;
    .restart local v3    # "serverUri":Ljava/net/URI;
    :cond_2
    :try_start_1
    sget-object v4, Ljava/net/Proxy$Type;->HTTP:Ljava/net/Proxy$Type;

    invoke-virtual {v2}, Ljava/net/Proxy;->type()Ljava/net/Proxy$Type;

    move-result-object v5

    if-ne v4, v5, :cond_1

    .line 78
    invoke-virtual {v2}, Ljava/net/Proxy;->address()Ljava/net/SocketAddress;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Object;->toString()Ljava/lang/String;
    :try_end_1
    .catch Ljava/net/URISyntaxException; {:try_start_1 .. :try_end_1} :catch_2
    .catch Ljava/lang/IllegalArgumentException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/IndexOutOfBoundsException; {:try_start_1 .. :try_end_1} :catch_0

    move-result-object v4

    goto :goto_0

    .line 84
    .end local v0    # "defaultProxySelector":Ljava/net/ProxySelector;
    .end local v1    # "proxyServers":Ljava/util/List;, "Ljava/util/List<Ljava/net/Proxy;>;"
    .end local v2    # "proxyUrl":Ljava/net/Proxy;
    .end local v3    # "serverUri":Ljava/net/URI;
    :catch_0
    move-exception v4

    goto :goto_1

    .line 82
    :catch_1
    move-exception v4

    goto :goto_1

    .line 80
    :catch_2
    move-exception v4

    goto :goto_1
.end method

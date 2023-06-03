.class public Lcom/adobe/air/AndroidMediaStream;
.super Ljava/lang/Object;
.source "AndroidMediaStream.java"


# static fields
.field private static final ERROR:I = -0x2


# instance fields
.field private mBufferSize:I

.field private mBufferedStream:Ljava/io/BufferedInputStream;

.field private mContentURI:Landroid/net/Uri;


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    iput-object v1, p0, Lcom/adobe/air/AndroidMediaStream;->mBufferedStream:Ljava/io/BufferedInputStream;

    .line 38
    const/4 v0, 0x0

    iput v0, p0, Lcom/adobe/air/AndroidMediaStream;->mBufferSize:I

    .line 40
    iput-object v1, p0, Lcom/adobe/air/AndroidMediaStream;->mContentURI:Landroid/net/Uri;

    .line 46
    return-void
.end method


# virtual methods
.method public Close()V
    .locals 1

    .prologue
    .line 79
    iget-object v0, p0, Lcom/adobe/air/AndroidMediaStream;->mBufferedStream:Ljava/io/BufferedInputStream;

    if-eqz v0, :cond_0

    .line 81
    :try_start_0
    iget-object v0, p0, Lcom/adobe/air/AndroidMediaStream;->mBufferedStream:Ljava/io/BufferedInputStream;

    invoke-virtual {v0}, Ljava/io/BufferedInputStream;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 85
    :goto_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/AndroidMediaStream;->mBufferedStream:Ljava/io/BufferedInputStream;

    .line 88
    :cond_0
    return-void

    .line 82
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public Read([BI)I
    .locals 4
    .param p1, "buffer"    # [B
    .param p2, "count"    # I

    .prologue
    .line 67
    const/4 v1, 0x0

    .line 70
    .local v1, "readBytes":I
    :try_start_0
    iget-object v2, p0, Lcom/adobe/air/AndroidMediaStream;->mBufferedStream:Ljava/io/BufferedInputStream;

    const/4 v3, 0x0

    invoke-virtual {v2, p1, v3, p2}, Ljava/io/BufferedInputStream;->read([BII)I
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    move v2, v1

    .line 75
    :goto_0
    return v2

    .line 71
    :catch_0
    move-exception v0

    .line 72
    .local v0, "e":Ljava/io/IOException;
    const/4 v2, -0x2

    goto :goto_0
.end method

.method public loadContentURI(Ljava/lang/String;)Z
    .locals 6
    .param p1, "URI"    # Ljava/lang/String;

    .prologue
    const/4 v3, 0x0

    .line 49
    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v4

    iput-object v4, p0, Lcom/adobe/air/AndroidMediaStream;->mContentURI:Landroid/net/Uri;

    .line 50
    iget-object v4, p0, Lcom/adobe/air/AndroidMediaStream;->mBufferedStream:Ljava/io/BufferedInputStream;

    if-nez v4, :cond_0

    .line 51
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v0

    .line 53
    .local v0, "act":Lcom/adobe/air/AndroidActivityWrapper;
    :try_start_0
    invoke-virtual {v0}, Lcom/adobe/air/AndroidActivityWrapper;->getActivity()Landroid/app/Activity;

    move-result-object v4

    invoke-virtual {v4}, Landroid/app/Activity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    iget-object v5, p0, Lcom/adobe/air/AndroidMediaStream;->mContentURI:Landroid/net/Uri;

    invoke-virtual {v4, v5}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object v2

    .line 55
    .local v2, "is":Ljava/io/InputStream;
    new-instance v4, Ljava/io/BufferedInputStream;

    invoke-direct {v4, v2}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    iput-object v4, p0, Lcom/adobe/air/AndroidMediaStream;->mBufferedStream:Ljava/io/BufferedInputStream;
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 63
    .end local v0    # "act":Lcom/adobe/air/AndroidActivityWrapper;
    .end local v2    # "is":Ljava/io/InputStream;
    :cond_0
    const/4 v3, 0x1

    :goto_0
    return v3

    .line 56
    .restart local v0    # "act":Lcom/adobe/air/AndroidActivityWrapper;
    :catch_0
    move-exception v1

    .line 57
    .local v1, "e":Ljava/io/FileNotFoundException;
    goto :goto_0

    .line 59
    .end local v1    # "e":Ljava/io/FileNotFoundException;
    :catch_1
    move-exception v1

    .line 60
    .local v1, "e":Ljava/lang/Exception;
    goto :goto_0
.end method

.class Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;
.super Ljava/lang/Object;
.source "WandWebSocket.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/wand/connection/WandWebSocket;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "Handshake"
.end annotation


# static fields
.field private static final APPLICATION_URL:Ljava/lang/String; = "applicationURL"

.field private static final DESTINATION_ID:Ljava/lang/String; = "destinationID"

.field private static final PROTOCOL:Ljava/lang/String; = "protocol"

.field private static final PUBLISHER:Ljava/lang/String; = "publisher"

.field private static final SOURCE_ID:Ljava/lang/String; = "sourceID"

.field private static final STATUS:Ljava/lang/String; = "status"

.field private static final STATUS_SUCCESS:Ljava/lang/String; = "SUCCESS"

.field public static final TIMEOUT_MILLISECONDS:I = 0x7530

.field private static final VERSION:Ljava/lang/String; = "version"


# instance fields
.field private mApplicationURL:Ljava/lang/String;

.field private mDestinationID:Ljava/lang/String;

.field private mProtocol:Ljava/lang/String;

.field private mPublisher:Ljava/lang/String;

.field private mSourceID:Ljava/lang/String;

.field private mVersion:Ljava/lang/String;


# direct methods
.method private constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 178
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 143
    const-string v0, "WEBSOCKET"

    iput-object v0, p0, Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;->mProtocol:Ljava/lang/String;

    .line 144
    iput-object v1, p0, Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;->mVersion:Ljava/lang/String;

    .line 145
    iput-object v1, p0, Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;->mSourceID:Ljava/lang/String;

    .line 146
    iput-object v1, p0, Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;->mDestinationID:Ljava/lang/String;

    .line 147
    iput-object v1, p0, Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;->mPublisher:Ljava/lang/String;

    .line 148
    iput-object v1, p0, Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;->mApplicationURL:Ljava/lang/String;

    .line 178
    return-void
.end method

.method static synthetic access$1000(Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;

    .prologue
    .line 129
    iget-object v0, p0, Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;->mPublisher:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$1100(Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;

    .prologue
    .line 129
    iget-object v0, p0, Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;->mApplicationURL:Ljava/lang/String;

    return-object v0
.end method

.method public static parse(Ljava/lang/String;)Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;
    .locals 3
    .param p0, "handshakeMessage"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 186
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 188
    .local v1, "handshakeObject":Lorg/json/JSONObject;
    new-instance v0, Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;

    invoke-direct {v0}, Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;-><init>()V

    .line 189
    .local v0, "handshake":Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;
    const-string v2, "protocol"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v0, Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;->mProtocol:Ljava/lang/String;

    .line 190
    const-string v2, "version"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v0, Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;->mVersion:Ljava/lang/String;

    .line 191
    const-string v2, "sourceID"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v0, Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;->mSourceID:Ljava/lang/String;

    .line 192
    const-string v2, "destinationID"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v0, Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;->mDestinationID:Ljava/lang/String;

    .line 193
    const-string v2, "publisher"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    const-string v2, "publisher"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v0, Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;->mPublisher:Ljava/lang/String;

    .line 194
    :cond_0
    const-string v2, "applicationURL"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    const-string v2, "applicationURL"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v0, Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;->mApplicationURL:Ljava/lang/String;

    .line 196
    :cond_1
    return-object v0
.end method


# virtual methods
.method public getApplicationURL()Ljava/lang/String;
    .locals 1

    .prologue
    .line 172
    iget-object v0, p0, Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;->mApplicationURL:Ljava/lang/String;

    return-object v0
.end method

.method public getDestinationID()Ljava/lang/String;
    .locals 1

    .prologue
    .line 164
    iget-object v0, p0, Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;->mDestinationID:Ljava/lang/String;

    return-object v0
.end method

.method public getProtocol()Ljava/lang/String;
    .locals 1

    .prologue
    .line 151
    iget-object v0, p0, Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;->mProtocol:Ljava/lang/String;

    return-object v0
.end method

.method public getPublisher()Ljava/lang/String;
    .locals 1

    .prologue
    .line 168
    iget-object v0, p0, Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;->mPublisher:Ljava/lang/String;

    return-object v0
.end method

.method public getSourceID()Ljava/lang/String;
    .locals 1

    .prologue
    .line 160
    iget-object v0, p0, Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;->mSourceID:Ljava/lang/String;

    return-object v0
.end method

.method public getSuccessResponse(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p1, "sourceID"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 201
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 202
    .local v0, "successResponse":Lorg/json/JSONObject;
    const-string v1, "protocol"

    const-string v2, "WEBSOCKET"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 203
    const-string v1, "version"

    iget-object v2, p0, Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;->mVersion:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 204
    const-string v1, "sourceID"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 205
    const-string v1, "destinationID"

    iget-object v2, p0, Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;->mSourceID:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 206
    const-string v1, "status"

    const-string v2, "SUCCESS"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 208
    iget-object v1, p0, Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;->mVersion:Ljava/lang/String;

    const-string v2, "1.1.0"

    invoke-static {v1, v2}, Lcom/adobe/air/wand/Version;->isGreaterThanEqualTo(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 209
    const-string v1, "publisher"

    iget-object v2, p0, Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;->mPublisher:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 210
    const-string v1, "applicationURL"

    iget-object v2, p0, Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;->mApplicationURL:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 213
    :cond_0
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public getVersion()Ljava/lang/String;
    .locals 1

    .prologue
    .line 155
    iget-object v0, p0, Lcom/adobe/air/wand/connection/WandWebSocket$Handshake;->mVersion:Ljava/lang/String;

    return-object v0
.end method

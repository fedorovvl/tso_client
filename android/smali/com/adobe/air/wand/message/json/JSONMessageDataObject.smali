.class public Lcom/adobe/air/wand/message/json/JSONMessageDataObject;
.super Ljava/lang/Object;
.source "JSONMessageDataObject.java"

# interfaces
.implements Lcom/adobe/air/wand/message/MessageDataObject;


# instance fields
.field final mJSONObject:Lorg/json/JSONObject;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 33
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    iput-object v0, p0, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;->mJSONObject:Lorg/json/JSONObject;

    .line 34
    return-void
.end method

.method public constructor <init>(Lorg/json/JSONObject;)V
    .locals 0
    .param p1, "object"    # Lorg/json/JSONObject;

    .prologue
    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    iput-object p1, p0, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;->mJSONObject:Lorg/json/JSONObject;

    .line 38
    return-void
.end method


# virtual methods
.method public getArray(Ljava/lang/String;)Lcom/adobe/air/wand/message/MessageDataArray;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 74
    new-instance v0, Lcom/adobe/air/wand/message/json/JSONMessageDataArray;

    iget-object v1, p0, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;->mJSONObject:Lorg/json/JSONObject;

    invoke-virtual {v1, p1}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/adobe/air/wand/message/json/JSONMessageDataArray;-><init>(Lorg/json/JSONArray;)V

    return-object v0
.end method

.method public getBoolean(Ljava/lang/String;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 42
    iget-object v0, p0, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;->mJSONObject:Lorg/json/JSONObject;

    invoke-virtual {v0, p1}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public getDouble(Ljava/lang/String;)D
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 57
    iget-object v0, p0, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;->mJSONObject:Lorg/json/JSONObject;

    invoke-virtual {v0, p1}, Lorg/json/JSONObject;->getDouble(Ljava/lang/String;)D

    move-result-wide v0

    return-wide v0
.end method

.method public getInt(Ljava/lang/String;)I
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 47
    iget-object v0, p0, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;->mJSONObject:Lorg/json/JSONObject;

    invoke-virtual {v0, p1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public getLong(Ljava/lang/String;)J
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 52
    iget-object v0, p0, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;->mJSONObject:Lorg/json/JSONObject;

    invoke-virtual {v0, p1}, Lorg/json/JSONObject;->getLong(Ljava/lang/String;)J

    move-result-wide v0

    return-wide v0
.end method

.method public getNames()[Ljava/lang/String;
    .locals 5

    .prologue
    .line 135
    iget-object v4, p0, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;->mJSONObject:Lorg/json/JSONObject;

    invoke-virtual {v4}, Lorg/json/JSONObject;->names()Lorg/json/JSONArray;

    move-result-object v2

    .line 136
    .local v2, "jsonNames":Lorg/json/JSONArray;
    if-nez v2, :cond_1

    const/4 v3, 0x0

    .line 151
    :cond_0
    return-object v3

    .line 138
    :cond_1
    iget-object v4, p0, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;->mJSONObject:Lorg/json/JSONObject;

    invoke-virtual {v4}, Lorg/json/JSONObject;->length()I

    move-result v4

    new-array v3, v4, [Ljava/lang/String;

    .line 140
    .local v3, "names":[Ljava/lang/String;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v4, v3

    if-ge v1, v4, :cond_0

    .line 143
    :try_start_0
    invoke-virtual {v2, v1}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v3, v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 140
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 145
    :catch_0
    move-exception v0

    .line 147
    .local v0, "e":Ljava/lang/Exception;
    const-string v4, ""

    aput-object v4, v3, v1

    goto :goto_1
.end method

.method public getObject(Ljava/lang/String;)Lcom/adobe/air/wand/message/MessageDataObject;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 68
    new-instance v0, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;

    iget-object v1, p0, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;->mJSONObject:Lorg/json/JSONObject;

    invoke-virtual {v1, p1}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;-><init>(Lorg/json/JSONObject;)V

    return-object v0
.end method

.method public getString(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 62
    iget-object v0, p0, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;->mJSONObject:Lorg/json/JSONObject;

    invoke-virtual {v0, p1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public has(Ljava/lang/String;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    .line 129
    iget-object v0, p0, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;->mJSONObject:Lorg/json/JSONObject;

    invoke-virtual {v0, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public length()I
    .locals 1

    .prologue
    .line 163
    iget-object v0, p0, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;->mJSONObject:Lorg/json/JSONObject;

    invoke-virtual {v0}, Lorg/json/JSONObject;->length()I

    move-result v0

    return v0
.end method

.method public put(Ljava/lang/String;D)Lcom/adobe/air/wand/message/MessageDataObject;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # D
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 101
    iget-object v0, p0, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;->mJSONObject:Lorg/json/JSONObject;

    invoke-virtual {v0, p1, p2, p3}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 102
    return-object p0
.end method

.method public put(Ljava/lang/String;I)Lcom/adobe/air/wand/message/MessageDataObject;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 87
    iget-object v0, p0, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;->mJSONObject:Lorg/json/JSONObject;

    invoke-virtual {v0, p1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 88
    return-object p0
.end method

.method public put(Ljava/lang/String;J)Lcom/adobe/air/wand/message/MessageDataObject;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 94
    iget-object v0, p0, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;->mJSONObject:Lorg/json/JSONObject;

    invoke-virtual {v0, p1, p2, p3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 95
    return-object p0
.end method

.method public put(Ljava/lang/String;Lcom/adobe/air/wand/message/MessageDataArray;)Lcom/adobe/air/wand/message/MessageDataObject;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Lcom/adobe/air/wand/message/MessageDataArray;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 122
    iget-object v0, p0, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;->mJSONObject:Lorg/json/JSONObject;

    check-cast p2, Lcom/adobe/air/wand/message/json/JSONMessageDataArray;

    .end local p2    # "value":Lcom/adobe/air/wand/message/MessageDataArray;
    iget-object v1, p2, Lcom/adobe/air/wand/message/json/JSONMessageDataArray;->mJSONArray:Lorg/json/JSONArray;

    invoke-virtual {v0, p1, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 123
    return-object p0
.end method

.method public put(Ljava/lang/String;Lcom/adobe/air/wand/message/MessageDataObject;)Lcom/adobe/air/wand/message/MessageDataObject;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Lcom/adobe/air/wand/message/MessageDataObject;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 115
    iget-object v0, p0, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;->mJSONObject:Lorg/json/JSONObject;

    check-cast p2, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;

    .end local p2    # "value":Lcom/adobe/air/wand/message/MessageDataObject;
    iget-object v1, p2, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;->mJSONObject:Lorg/json/JSONObject;

    invoke-virtual {v0, p1, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 116
    return-object p0
.end method

.method public put(Ljava/lang/String;Ljava/lang/String;)Lcom/adobe/air/wand/message/MessageDataObject;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 108
    iget-object v0, p0, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;->mJSONObject:Lorg/json/JSONObject;

    invoke-virtual {v0, p1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 109
    return-object p0
.end method

.method public put(Ljava/lang/String;Z)Lcom/adobe/air/wand/message/MessageDataObject;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 80
    iget-object v0, p0, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;->mJSONObject:Lorg/json/JSONObject;

    invoke-virtual {v0, p1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 81
    return-object p0
.end method

.method public remove(Ljava/lang/String;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    .line 157
    iget-object v0, p0, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;->mJSONObject:Lorg/json/JSONObject;

    invoke-virtual {v0, p1}, Lorg/json/JSONObject;->remove(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

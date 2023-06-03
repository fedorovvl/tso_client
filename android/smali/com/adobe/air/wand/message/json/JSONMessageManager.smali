.class public Lcom/adobe/air/wand/message/json/JSONMessageManager;
.super Lcom/adobe/air/wand/message/MessageManager;
.source "JSONMessageManager.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 38
    invoke-direct {p0}, Lcom/adobe/air/wand/message/MessageManager;-><init>()V

    return-void
.end method

.method private static createJSONMessage(Lcom/adobe/air/wand/message/Message;)Lorg/json/JSONObject;
    .locals 14
    .param p0, "message"    # Lcom/adobe/air/wand/message/Message;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 166
    monitor-enter p0

    .line 168
    :try_start_0
    invoke-virtual {p0}, Lcom/adobe/air/wand/message/Message;->getHeader()Lcom/adobe/air/wand/message/Message$Header;

    move-result-object v11

    invoke-virtual {v11}, Lcom/adobe/air/wand/message/Message$Header;->getType()Lcom/adobe/air/wand/message/Message$Type;

    move-result-object v4

    .line 170
    .local v4, "msgType":Lcom/adobe/air/wand/message/Message$Type;
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 171
    .local v2, "jsonHeader":Lorg/json/JSONObject;
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 173
    .local v1, "jsonData":Lorg/json/JSONObject;
    const/4 v0, 0x0

    .line 175
    .local v0, "header":Lcom/adobe/air/wand/message/Message$Header;
    sget-object v11, Lcom/adobe/air/wand/message/json/JSONMessageManager$1;->$SwitchMap$com$adobe$air$wand$message$Message$Type:[I

    invoke-virtual {v4}, Lcom/adobe/air/wand/message/Message$Type;->ordinal()I

    move-result v12

    aget v11, v11, v12

    packed-switch v11, :pswitch_data_0

    .line 210
    new-instance v11, Ljava/lang/Exception;

    const-string v12, "Unsupported message type"

    invoke-direct {v11, v12}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw v11

    .line 222
    .end local v0    # "header":Lcom/adobe/air/wand/message/Message$Header;
    .end local v1    # "jsonData":Lorg/json/JSONObject;
    .end local v2    # "jsonHeader":Lorg/json/JSONObject;
    .end local v4    # "msgType":Lcom/adobe/air/wand/message/Message$Type;
    :catchall_0
    move-exception v11

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v11

    .line 177
    .restart local v0    # "header":Lcom/adobe/air/wand/message/Message$Header;
    .restart local v1    # "jsonData":Lorg/json/JSONObject;
    .restart local v2    # "jsonHeader":Lorg/json/JSONObject;
    .restart local v4    # "msgType":Lcom/adobe/air/wand/message/Message$Type;
    :pswitch_0
    :try_start_1
    invoke-virtual {p0}, Lcom/adobe/air/wand/message/Message;->getHeader()Lcom/adobe/air/wand/message/Message$Header;

    move-result-object v8

    check-cast v8, Lcom/adobe/air/wand/message/Request$Header;

    .line 178
    .local v8, "requestHeader":Lcom/adobe/air/wand/message/Request$Header;
    invoke-virtual {p0}, Lcom/adobe/air/wand/message/Message;->getData()Lcom/adobe/air/wand/message/Message$Data;

    move-result-object v7

    check-cast v7, Lcom/adobe/air/wand/message/Request$Data;

    .line 180
    .local v7, "requestData":Lcom/adobe/air/wand/message/Request$Data;
    move-object v0, v8

    .line 182
    const-string v11, "taskID"

    invoke-virtual {v8}, Lcom/adobe/air/wand/message/Request$Header;->getTaskID()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v2, v11, v12}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 183
    const-string v12, "arguments"

    invoke-virtual {v7}, Lcom/adobe/air/wand/message/Request$Data;->getArguments()Lcom/adobe/air/wand/message/MessageDataArray;

    move-result-object v11

    check-cast v11, Lcom/adobe/air/wand/message/json/JSONMessageDataArray;

    iget-object v11, v11, Lcom/adobe/air/wand/message/json/JSONMessageDataArray;->mJSONArray:Lorg/json/JSONArray;

    invoke-virtual {v1, v12, v11}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 213
    .end local v7    # "requestData":Lcom/adobe/air/wand/message/Request$Data;
    .end local v8    # "requestHeader":Lcom/adobe/air/wand/message/Request$Header;
    :goto_0
    const-string v11, "title"

    invoke-virtual {v0}, Lcom/adobe/air/wand/message/Message$Header;->getTitle()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v2, v11, v12}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 214
    const-string v11, "type"

    invoke-virtual {v0}, Lcom/adobe/air/wand/message/Message$Header;->getType()Lcom/adobe/air/wand/message/Message$Type;

    move-result-object v12

    invoke-virtual {v12}, Lcom/adobe/air/wand/message/Message$Type;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v2, v11, v12}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 215
    const-string v11, "timestamp"

    invoke-virtual {v0}, Lcom/adobe/air/wand/message/Message$Header;->getTimestamp()J

    move-result-wide v12

    invoke-virtual {v2, v11, v12, v13}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 217
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    .line 218
    .local v3, "jsonMessage":Lorg/json/JSONObject;
    const-string v11, "header"

    invoke-virtual {v3, v11, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 219
    const-string v11, "data"

    invoke-virtual {v3, v11, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 221
    monitor-exit p0

    return-object v3

    .line 188
    .end local v3    # "jsonMessage":Lorg/json/JSONObject;
    :pswitch_1
    invoke-virtual {p0}, Lcom/adobe/air/wand/message/Message;->getHeader()Lcom/adobe/air/wand/message/Message$Header;

    move-result-object v10

    check-cast v10, Lcom/adobe/air/wand/message/Response$Header;

    .line 189
    .local v10, "responseHeader":Lcom/adobe/air/wand/message/Response$Header;
    invoke-virtual {p0}, Lcom/adobe/air/wand/message/Message;->getData()Lcom/adobe/air/wand/message/Message$Data;

    move-result-object v9

    check-cast v9, Lcom/adobe/air/wand/message/Response$Data;

    .line 191
    .local v9, "responseData":Lcom/adobe/air/wand/message/Response$Data;
    move-object v0, v10

    .line 193
    const-string v11, "status"

    invoke-virtual {v10}, Lcom/adobe/air/wand/message/Response$Header;->getStatus()Lcom/adobe/air/wand/message/Response$Status;

    move-result-object v12

    invoke-virtual {v12}, Lcom/adobe/air/wand/message/Response$Status;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v2, v11, v12}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 194
    const-string v11, "taskID"

    invoke-virtual {v10}, Lcom/adobe/air/wand/message/Response$Header;->getTaskID()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v2, v11, v12}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 195
    const-string v12, "result"

    invoke-virtual {v9}, Lcom/adobe/air/wand/message/Response$Data;->getResult()Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;

    iget-object v11, v11, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;->mJSONObject:Lorg/json/JSONObject;

    invoke-virtual {v1, v12, v11}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_0

    .line 200
    .end local v9    # "responseData":Lcom/adobe/air/wand/message/Response$Data;
    .end local v10    # "responseHeader":Lcom/adobe/air/wand/message/Response$Header;
    :pswitch_2
    invoke-virtual {p0}, Lcom/adobe/air/wand/message/Message;->getHeader()Lcom/adobe/air/wand/message/Message$Header;

    move-result-object v6

    check-cast v6, Lcom/adobe/air/wand/message/Notification$Header;

    .line 201
    .local v6, "notificationHeader":Lcom/adobe/air/wand/message/Notification$Header;
    invoke-virtual {p0}, Lcom/adobe/air/wand/message/Message;->getData()Lcom/adobe/air/wand/message/Message$Data;

    move-result-object v5

    check-cast v5, Lcom/adobe/air/wand/message/Notification$Data;

    .line 203
    .local v5, "notificationData":Lcom/adobe/air/wand/message/Notification$Data;
    move-object v0, v6

    .line 205
    const-string v12, "notification"

    invoke-virtual {v5}, Lcom/adobe/air/wand/message/Notification$Data;->getNotification()Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;

    iget-object v11, v11, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;->mJSONObject:Lorg/json/JSONObject;

    invoke-virtual {v1, v12, v11}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 175
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method private static createWandMessage(Lorg/json/JSONObject;)Lcom/adobe/air/wand/message/Message;
    .locals 18
    .param p0, "jsonMessage"    # Lorg/json/JSONObject;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 106
    monitor-enter p0

    .line 108
    :try_start_0
    const-string v16, "header"

    move-object/from16 v0, p0

    move-object/from16 v1, v16

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v11

    .line 109
    .local v11, "jsonHeader":Lorg/json/JSONObject;
    const-string v16, "data"

    move-object/from16 v0, p0

    move-object/from16 v1, v16

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v10

    .line 111
    .local v10, "jsonData":Lorg/json/JSONObject;
    const-string v16, "title"

    move-object/from16 v0, v16

    invoke-virtual {v11, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 112
    .local v4, "msgTitle":Ljava/lang/String;
    const-string v16, "type"

    move-object/from16 v0, v16

    invoke-virtual {v11, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    .line 113
    .local v14, "msgType":Ljava/lang/String;
    const-string v16, "timestamp"

    move-object/from16 v0, v16

    invoke-virtual {v11, v0}, Lorg/json/JSONObject;->getLong(Ljava/lang/String;)J

    move-result-wide v6

    .line 115
    .local v6, "msgTimestamp":J
    const/4 v13, 0x0

    .line 117
    .local v13, "message":Lcom/adobe/air/wand/message/Message;
    sget-object v16, Lcom/adobe/air/wand/message/Message$Type;->REQUEST:Lcom/adobe/air/wand/message/Message$Type;

    invoke-virtual/range {v16 .. v16}, Lcom/adobe/air/wand/message/Message$Type;->toString()Ljava/lang/String;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-virtual {v14, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v16

    if-eqz v16, :cond_1

    .line 119
    const-string v16, "taskID"

    move-object/from16 v0, v16

    invoke-virtual {v11, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 120
    .local v5, "msgTaskID":Ljava/lang/String;
    const-string v16, "arguments"

    move-object/from16 v0, v16

    invoke-virtual {v10, v0}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v9

    .line 122
    .local v9, "jsonArgs":Lorg/json/JSONArray;
    new-instance v3, Lcom/adobe/air/wand/message/Request$Header;

    invoke-direct {v3, v4, v5, v6, v7}, Lcom/adobe/air/wand/message/Request$Header;-><init>(Ljava/lang/String;Ljava/lang/String;J)V

    .line 123
    .local v3, "header":Lcom/adobe/air/wand/message/Request$Header;
    new-instance v2, Lcom/adobe/air/wand/message/Request$Data;

    new-instance v16, Lcom/adobe/air/wand/message/json/JSONMessageDataArray;

    move-object/from16 v0, v16

    invoke-direct {v0, v9}, Lcom/adobe/air/wand/message/json/JSONMessageDataArray;-><init>(Lorg/json/JSONArray;)V

    move-object/from16 v0, v16

    invoke-direct {v2, v0}, Lcom/adobe/air/wand/message/Request$Data;-><init>(Lcom/adobe/air/wand/message/MessageDataArray;)V

    .line 125
    .local v2, "data":Lcom/adobe/air/wand/message/Request$Data;
    new-instance v13, Lcom/adobe/air/wand/message/Request;

    .end local v13    # "message":Lcom/adobe/air/wand/message/Message;
    invoke-direct {v13, v3, v2}, Lcom/adobe/air/wand/message/Request;-><init>(Lcom/adobe/air/wand/message/Request$Header;Lcom/adobe/air/wand/message/Request$Data;)V

    .line 160
    .end local v2    # "data":Lcom/adobe/air/wand/message/Request$Data;
    .end local v3    # "header":Lcom/adobe/air/wand/message/Request$Header;
    .end local v5    # "msgTaskID":Ljava/lang/String;
    .end local v9    # "jsonArgs":Lorg/json/JSONArray;
    .restart local v13    # "message":Lcom/adobe/air/wand/message/Message;
    :cond_0
    :goto_0
    monitor-exit p0

    return-object v13

    .line 127
    :cond_1
    sget-object v16, Lcom/adobe/air/wand/message/Message$Type;->RESPONSE:Lcom/adobe/air/wand/message/Message$Type;

    invoke-virtual/range {v16 .. v16}, Lcom/adobe/air/wand/message/Message$Type;->toString()Ljava/lang/String;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-virtual {v14, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v16

    if-eqz v16, :cond_4

    .line 129
    const-string v16, "taskID"

    move-object/from16 v0, v16

    invoke-virtual {v11, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 130
    .restart local v5    # "msgTaskID":Ljava/lang/String;
    const-string v16, "status"

    move-object/from16 v0, v16

    invoke-virtual {v11, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    .line 134
    .local v12, "jsonStatus":Ljava/lang/String;
    sget-object v16, Lcom/adobe/air/wand/message/Response$Status;->SUCCESS:Lcom/adobe/air/wand/message/Response$Status;

    invoke-virtual/range {v16 .. v16}, Lcom/adobe/air/wand/message/Response$Status;->toString()Ljava/lang/String;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-virtual {v12, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v16

    if-eqz v16, :cond_2

    .line 135
    sget-object v8, Lcom/adobe/air/wand/message/Response$Status;->SUCCESS:Lcom/adobe/air/wand/message/Response$Status;

    .line 142
    .local v8, "msgStatus":Lcom/adobe/air/wand/message/Response$Status;
    :goto_1
    const-string v16, "result"

    move-object/from16 v0, v16

    invoke-virtual {v10, v0}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v15

    .line 144
    .local v15, "resultObject":Lorg/json/JSONObject;
    new-instance v3, Lcom/adobe/air/wand/message/Response$Header;

    invoke-direct/range {v3 .. v8}, Lcom/adobe/air/wand/message/Response$Header;-><init>(Ljava/lang/String;Ljava/lang/String;JLcom/adobe/air/wand/message/Response$Status;)V

    .line 145
    .local v3, "header":Lcom/adobe/air/wand/message/Response$Header;
    new-instance v2, Lcom/adobe/air/wand/message/Response$Data;

    new-instance v16, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;

    move-object/from16 v0, v16

    invoke-direct {v0, v15}, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;-><init>(Lorg/json/JSONObject;)V

    move-object/from16 v0, v16

    invoke-direct {v2, v0}, Lcom/adobe/air/wand/message/Response$Data;-><init>(Lcom/adobe/air/wand/message/MessageDataObject;)V

    .line 147
    .local v2, "data":Lcom/adobe/air/wand/message/Response$Data;
    new-instance v13, Lcom/adobe/air/wand/message/Response;

    .end local v13    # "message":Lcom/adobe/air/wand/message/Message;
    invoke-direct {v13, v3, v2}, Lcom/adobe/air/wand/message/Response;-><init>(Lcom/adobe/air/wand/message/Response$Header;Lcom/adobe/air/wand/message/Response$Data;)V

    .line 149
    .restart local v13    # "message":Lcom/adobe/air/wand/message/Message;
    goto :goto_0

    .line 136
    .end local v2    # "data":Lcom/adobe/air/wand/message/Response$Data;
    .end local v3    # "header":Lcom/adobe/air/wand/message/Response$Header;
    .end local v8    # "msgStatus":Lcom/adobe/air/wand/message/Response$Status;
    .end local v15    # "resultObject":Lorg/json/JSONObject;
    :cond_2
    sget-object v16, Lcom/adobe/air/wand/message/Response$Status;->ERROR:Lcom/adobe/air/wand/message/Response$Status;

    invoke-virtual/range {v16 .. v16}, Lcom/adobe/air/wand/message/Response$Status;->toString()Ljava/lang/String;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-virtual {v12, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v16

    if-eqz v16, :cond_3

    .line 137
    sget-object v8, Lcom/adobe/air/wand/message/Response$Status;->ERROR:Lcom/adobe/air/wand/message/Response$Status;

    .restart local v8    # "msgStatus":Lcom/adobe/air/wand/message/Response$Status;
    goto :goto_1

    .line 139
    .end local v8    # "msgStatus":Lcom/adobe/air/wand/message/Response$Status;
    :cond_3
    new-instance v16, Ljava/lang/Exception;

    const-string v17, "Unable to fetch Response status"

    invoke-direct/range {v16 .. v17}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw v16

    .line 161
    .end local v4    # "msgTitle":Ljava/lang/String;
    .end local v5    # "msgTaskID":Ljava/lang/String;
    .end local v6    # "msgTimestamp":J
    .end local v10    # "jsonData":Lorg/json/JSONObject;
    .end local v11    # "jsonHeader":Lorg/json/JSONObject;
    .end local v12    # "jsonStatus":Ljava/lang/String;
    .end local v13    # "message":Lcom/adobe/air/wand/message/Message;
    .end local v14    # "msgType":Ljava/lang/String;
    :catchall_0
    move-exception v16

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v16

    .line 149
    .restart local v4    # "msgTitle":Ljava/lang/String;
    .restart local v6    # "msgTimestamp":J
    .restart local v10    # "jsonData":Lorg/json/JSONObject;
    .restart local v11    # "jsonHeader":Lorg/json/JSONObject;
    .restart local v13    # "message":Lcom/adobe/air/wand/message/Message;
    .restart local v14    # "msgType":Ljava/lang/String;
    :cond_4
    :try_start_1
    sget-object v16, Lcom/adobe/air/wand/message/Message$Type;->NOTIFICATION:Lcom/adobe/air/wand/message/Message$Type;

    invoke-virtual/range {v16 .. v16}, Lcom/adobe/air/wand/message/Message$Type;->toString()Ljava/lang/String;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-virtual {v14, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v16

    if-eqz v16, :cond_0

    .line 151
    const-string v16, "notification"

    move-object/from16 v0, v16

    invoke-virtual {v10, v0}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v15

    .line 153
    .restart local v15    # "resultObject":Lorg/json/JSONObject;
    new-instance v3, Lcom/adobe/air/wand/message/Notification$Header;

    invoke-direct {v3, v4, v6, v7}, Lcom/adobe/air/wand/message/Notification$Header;-><init>(Ljava/lang/String;J)V

    .line 154
    .local v3, "header":Lcom/adobe/air/wand/message/Notification$Header;
    new-instance v2, Lcom/adobe/air/wand/message/Notification$Data;

    new-instance v16, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;

    move-object/from16 v0, v16

    invoke-direct {v0, v15}, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;-><init>(Lorg/json/JSONObject;)V

    move-object/from16 v0, v16

    invoke-direct {v2, v0}, Lcom/adobe/air/wand/message/Notification$Data;-><init>(Lcom/adobe/air/wand/message/MessageDataObject;)V

    .line 156
    .local v2, "data":Lcom/adobe/air/wand/message/Notification$Data;
    new-instance v13, Lcom/adobe/air/wand/message/Notification;

    .end local v13    # "message":Lcom/adobe/air/wand/message/Message;
    invoke-direct {v13, v3, v2}, Lcom/adobe/air/wand/message/Notification;-><init>(Lcom/adobe/air/wand/message/Notification$Header;Lcom/adobe/air/wand/message/Notification$Data;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .restart local v13    # "message":Lcom/adobe/air/wand/message/Message;
    goto/16 :goto_0
.end method


# virtual methods
.method public createDataArray()Lcom/adobe/air/wand/message/MessageDataArray;
    .locals 1

    .prologue
    .line 49
    new-instance v0, Lcom/adobe/air/wand/message/json/JSONMessageDataArray;

    invoke-direct {v0}, Lcom/adobe/air/wand/message/json/JSONMessageDataArray;-><init>()V

    return-object v0
.end method

.method public createDataObject()Lcom/adobe/air/wand/message/MessageDataObject;
    .locals 1

    .prologue
    .line 43
    new-instance v0, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;

    invoke-direct {v0}, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;-><init>()V

    return-object v0
.end method

.method public createWandNotification(Ljava/lang/String;Lcom/adobe/air/wand/message/MessageDataObject;)Lcom/adobe/air/wand/message/Notification;
    .locals 4
    .param p1, "title"    # Ljava/lang/String;
    .param p2, "notification"    # Lcom/adobe/air/wand/message/MessageDataObject;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 94
    new-instance v1, Lcom/adobe/air/wand/message/Notification$Header;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-direct {v1, p1, v2, v3}, Lcom/adobe/air/wand/message/Notification$Header;-><init>(Ljava/lang/String;J)V

    .line 95
    .local v1, "header":Lcom/adobe/air/wand/message/Notification$Header;
    if-nez p2, :cond_0

    .line 96
    new-instance p2, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;

    .end local p2    # "notification":Lcom/adobe/air/wand/message/MessageDataObject;
    invoke-direct {p2}, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;-><init>()V

    .line 99
    .restart local p2    # "notification":Lcom/adobe/air/wand/message/MessageDataObject;
    :cond_0
    new-instance v0, Lcom/adobe/air/wand/message/Notification$Data;

    invoke-direct {v0, p2}, Lcom/adobe/air/wand/message/Notification$Data;-><init>(Lcom/adobe/air/wand/message/MessageDataObject;)V

    .line 101
    .local v0, "data":Lcom/adobe/air/wand/message/Notification$Data;
    new-instance v2, Lcom/adobe/air/wand/message/Notification;

    invoke-direct {v2, v1, v0}, Lcom/adobe/air/wand/message/Notification;-><init>(Lcom/adobe/air/wand/message/Notification$Header;Lcom/adobe/air/wand/message/Notification$Data;)V

    return-object v2
.end method

.method public createWandRequest(Ljava/lang/String;Ljava/lang/String;Lcom/adobe/air/wand/message/MessageDataArray;)Lcom/adobe/air/wand/message/Request;
    .locals 4
    .param p1, "title"    # Ljava/lang/String;
    .param p2, "taskID"    # Ljava/lang/String;
    .param p3, "args"    # Lcom/adobe/air/wand/message/MessageDataArray;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 67
    new-instance v1, Lcom/adobe/air/wand/message/Request$Header;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-direct {v1, p1, p2, v2, v3}, Lcom/adobe/air/wand/message/Request$Header;-><init>(Ljava/lang/String;Ljava/lang/String;J)V

    .line 68
    .local v1, "header":Lcom/adobe/air/wand/message/Request$Header;
    if-nez p3, :cond_0

    .line 69
    new-instance p3, Lcom/adobe/air/wand/message/json/JSONMessageDataArray;

    .end local p3    # "args":Lcom/adobe/air/wand/message/MessageDataArray;
    invoke-direct {p3}, Lcom/adobe/air/wand/message/json/JSONMessageDataArray;-><init>()V

    .line 72
    .restart local p3    # "args":Lcom/adobe/air/wand/message/MessageDataArray;
    :cond_0
    new-instance v0, Lcom/adobe/air/wand/message/Request$Data;

    invoke-direct {v0, p3}, Lcom/adobe/air/wand/message/Request$Data;-><init>(Lcom/adobe/air/wand/message/MessageDataArray;)V

    .line 74
    .local v0, "data":Lcom/adobe/air/wand/message/Request$Data;
    new-instance v2, Lcom/adobe/air/wand/message/Request;

    invoke-direct {v2, v1, v0}, Lcom/adobe/air/wand/message/Request;-><init>(Lcom/adobe/air/wand/message/Request$Header;Lcom/adobe/air/wand/message/Request$Data;)V

    return-object v2
.end method

.method public createWandResponse(Ljava/lang/String;Ljava/lang/String;Lcom/adobe/air/wand/message/MessageDataObject;Lcom/adobe/air/wand/message/Response$Status;)Lcom/adobe/air/wand/message/Response;
    .locals 7
    .param p1, "title"    # Ljava/lang/String;
    .param p2, "taskID"    # Ljava/lang/String;
    .param p3, "result"    # Lcom/adobe/air/wand/message/MessageDataObject;
    .param p4, "status"    # Lcom/adobe/air/wand/message/Response$Status;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 80
    new-instance v1, Lcom/adobe/air/wand/message/Response$Header;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    move-object v2, p1

    move-object v3, p2

    move-object v6, p4

    invoke-direct/range {v1 .. v6}, Lcom/adobe/air/wand/message/Response$Header;-><init>(Ljava/lang/String;Ljava/lang/String;JLcom/adobe/air/wand/message/Response$Status;)V

    .line 81
    .local v1, "header":Lcom/adobe/air/wand/message/Response$Header;
    if-nez p3, :cond_0

    .line 82
    new-instance p3, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;

    .end local p3    # "result":Lcom/adobe/air/wand/message/MessageDataObject;
    invoke-direct {p3}, Lcom/adobe/air/wand/message/json/JSONMessageDataObject;-><init>()V

    .line 85
    .restart local p3    # "result":Lcom/adobe/air/wand/message/MessageDataObject;
    :cond_0
    new-instance v0, Lcom/adobe/air/wand/message/Response$Data;

    invoke-direct {v0, p3}, Lcom/adobe/air/wand/message/Response$Data;-><init>(Lcom/adobe/air/wand/message/MessageDataObject;)V

    .line 87
    .local v0, "data":Lcom/adobe/air/wand/message/Response$Data;
    new-instance v2, Lcom/adobe/air/wand/message/Response;

    invoke-direct {v2, v1, v0}, Lcom/adobe/air/wand/message/Response;-><init>(Lcom/adobe/air/wand/message/Response$Header;Lcom/adobe/air/wand/message/Response$Data;)V

    return-object v2
.end method

.method public deserializeWandMessage(Ljava/lang/String;)Lcom/adobe/air/wand/message/Message;
    .locals 1
    .param p1, "wandMessage"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 61
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lcom/adobe/air/wand/message/json/JSONMessageManager;->createWandMessage(Lorg/json/JSONObject;)Lcom/adobe/air/wand/message/Message;

    move-result-object v0

    return-object v0
.end method

.method public serializeMessage(Lcom/adobe/air/wand/message/Message;)Ljava/lang/String;
    .locals 1
    .param p1, "message"    # Lcom/adobe/air/wand/message/Message;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 55
    invoke-static {p1}, Lcom/adobe/air/wand/message/json/JSONMessageManager;->createJSONMessage(Lcom/adobe/air/wand/message/Message;)Lorg/json/JSONObject;

    move-result-object v0

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

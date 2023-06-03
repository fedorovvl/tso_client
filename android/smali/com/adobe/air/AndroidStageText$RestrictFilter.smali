.class Lcom/adobe/air/AndroidStageText$RestrictFilter;
.super Ljava/lang/Object;
.source "AndroidStageText.java"

# interfaces
.implements Landroid/text/InputFilter;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/AndroidStageText;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "RestrictFilter"
.end annotation


# static fields
.field private static final kMapSize:I = 0x2000


# instance fields
.field private mPattern:Ljava/lang/String;

.field private m_map:[B

.field final synthetic this$0:Lcom/adobe/air/AndroidStageText;


# direct methods
.method public constructor <init>(Lcom/adobe/air/AndroidStageText;Ljava/lang/String;)V
    .locals 12
    .param p2, "pattern"    # Ljava/lang/String;

    .prologue
    const/4 v10, 0x0

    const/4 v8, 0x1

    const/4 v9, 0x0

    .line 1243
    iput-object p1, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->this$0:Lcom/adobe/air/AndroidStageText;

    .line 1244
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1237
    iput-object v10, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->mPattern:Ljava/lang/String;

    .line 1238
    iput-object v10, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->m_map:[B

    .line 1245
    iput-object p2, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->mPattern:Ljava/lang/String;

    .line 1246
    if-eqz p2, :cond_6

    .line 1248
    const-string v10, ""

    invoke-virtual {v10, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-nez v10, :cond_6

    .line 1250
    const/16 v10, 0x2000

    new-array v10, v10, [B

    iput-object v10, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->m_map:[B

    .line 1251
    invoke-virtual {p0, v9}, Lcom/adobe/air/AndroidStageText$RestrictFilter;->SetAll(Z)V

    .line 1252
    const/4 v3, 0x0

    .line 1253
    .local v3, "inBackSlash":Z
    const/4 v4, 0x0

    .line 1254
    .local v4, "inRange":Z
    const/4 v7, 0x1

    .line 1255
    .local v7, "setFlag":Z
    const/4 v6, 0x0

    .line 1256
    .local v6, "lastCode":C
    invoke-virtual {p2, v9}, Ljava/lang/String;->charAt(I)C

    move-result v10

    const/16 v11, 0x5e

    if-ne v10, v11, :cond_0

    .line 1259
    invoke-virtual {p0, v8}, Lcom/adobe/air/AndroidStageText$RestrictFilter;->SetAll(Z)V

    .line 1261
    :cond_0
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v10

    if-ge v2, v10, :cond_6

    .line 1263
    invoke-virtual {p2, v2}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 1264
    .local v1, "code":C
    const/4 v0, 0x0

    .line 1265
    .local v0, "acceptCode":Z
    if-nez v3, :cond_2

    .line 1267
    sparse-switch v1, :sswitch_data_0

    .line 1281
    const/4 v0, 0x1

    .line 1290
    :goto_1
    if-eqz v0, :cond_4

    .line 1291
    if-eqz v4, :cond_5

    .line 1292
    move v5, v6

    .local v5, "j":C
    :goto_2
    if-gt v5, v1, :cond_3

    .line 1293
    invoke-virtual {p0, v5, v7}, Lcom/adobe/air/AndroidStageText$RestrictFilter;->SetCode(CZ)V

    .line 1292
    add-int/lit8 v10, v5, 0x1

    int-to-char v5, v10

    goto :goto_2

    .line 1269
    .end local v5    # "j":C
    :sswitch_0
    const/4 v4, 0x1

    .line 1270
    goto :goto_1

    .line 1272
    :sswitch_1
    if-nez v7, :cond_1

    move v7, v8

    .line 1273
    :goto_3
    goto :goto_1

    :cond_1
    move v7, v9

    .line 1272
    goto :goto_3

    .line 1276
    :sswitch_2
    const/4 v3, 0x1

    .line 1277
    goto :goto_1

    .line 1287
    :cond_2
    const/4 v0, 0x1

    .line 1288
    const/4 v3, 0x0

    goto :goto_1

    .line 1295
    .restart local v5    # "j":C
    :cond_3
    const/4 v4, 0x0

    .line 1296
    const/4 v6, 0x0

    .line 1261
    .end local v5    # "j":C
    :cond_4
    :goto_4
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 1298
    :cond_5
    invoke-virtual {p0, v1, v7}, Lcom/adobe/air/AndroidStageText$RestrictFilter;->SetCode(CZ)V

    .line 1299
    move v6, v1

    goto :goto_4

    .line 1305
    .end local v0    # "acceptCode":Z
    .end local v1    # "code":C
    .end local v2    # "i":I
    .end local v3    # "inBackSlash":Z
    .end local v4    # "inRange":Z
    .end local v6    # "lastCode":C
    .end local v7    # "setFlag":Z
    :cond_6
    return-void

    .line 1267
    :sswitch_data_0
    .sparse-switch
        0x2d -> :sswitch_0
        0x5c -> :sswitch_2
        0x5e -> :sswitch_1
    .end sparse-switch
.end method


# virtual methods
.method IsCharAvailable(C)Z
    .locals 4
    .param p1, "code"    # C

    .prologue
    const/4 v1, 0x1

    .line 1387
    const/4 v0, 0x1

    .line 1388
    .local v0, "result":Z
    iget-object v2, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->mPattern:Ljava/lang/String;

    if-nez v2, :cond_0

    .line 1389
    const/4 v0, 0x1

    .line 1391
    :cond_0
    iget-object v2, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->m_map:[B

    if-nez v2, :cond_1

    .line 1393
    const/4 v0, 0x0

    .line 1400
    :goto_0
    return v0

    .line 1397
    :cond_1
    iget-object v2, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->m_map:[B

    shr-int/lit8 v3, p1, 0x3

    aget-byte v2, v2, v3

    and-int/lit8 v3, p1, 0x7

    shl-int v3, v1, v3

    and-int/2addr v2, v3

    if-eqz v2, :cond_2

    move v0, v1

    :goto_1
    goto :goto_0

    :cond_2
    const/4 v0, 0x0

    goto :goto_1
.end method

.method IsEmpty()Z
    .locals 1

    .prologue
    .line 1382
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->mPattern:Ljava/lang/String;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method SetAll(Z)V
    .locals 3
    .param p1, "on"    # Z

    .prologue
    .line 1414
    if-eqz p1, :cond_0

    const/16 v2, 0xff

    :goto_0
    int-to-byte v1, v2

    .line 1415
    .local v1, "val":B
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    const/16 v2, 0x2000

    if-ge v0, v2, :cond_1

    .line 1417
    iget-object v2, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->m_map:[B

    aput-byte v1, v2, v0

    .line 1415
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 1414
    .end local v0    # "i":I
    .end local v1    # "val":B
    :cond_0
    const/4 v2, 0x0

    goto :goto_0

    .line 1419
    .restart local v0    # "i":I
    .restart local v1    # "val":B
    :cond_1
    return-void
.end method

.method SetCode(CZ)V
    .locals 5
    .param p1, "code"    # C
    .param p2, "on"    # Z

    .prologue
    const/4 v4, 0x1

    .line 1405
    if-eqz p2, :cond_0

    .line 1406
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->m_map:[B

    shr-int/lit8 v1, p1, 0x3

    aget-byte v2, v0, v1

    and-int/lit8 v3, p1, 0x7

    shl-int v3, v4, v3

    or-int/2addr v2, v3

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    .line 1410
    :goto_0
    return-void

    .line 1408
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->m_map:[B

    shr-int/lit8 v1, p1, 0x3

    aget-byte v2, v0, v1

    and-int/lit8 v3, p1, 0x7

    shl-int v3, v4, v3

    xor-int/lit8 v3, v3, -0x1

    and-int/2addr v2, v3

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    goto :goto_0
.end method

.method public filter(Ljava/lang/CharSequence;IILandroid/text/Spanned;II)Ljava/lang/CharSequence;
    .locals 14
    .param p1, "source"    # Ljava/lang/CharSequence;
    .param p2, "start"    # I
    .param p3, "end"    # I
    .param p4, "dest"    # Landroid/text/Spanned;
    .param p5, "dstart"    # I
    .param p6, "dend"    # I

    .prologue
    .line 1312
    iget-object v1, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->mPattern:Ljava/lang/String;

    if-nez v1, :cond_0

    .line 1314
    const/4 v11, 0x0

    .local v11, "result":Ljava/lang/CharSequence;
    :goto_0
    move-object v5, v11

    .line 1377
    .end local v11    # "result":Ljava/lang/CharSequence;
    :goto_1
    return-object v5

    .line 1316
    :cond_0
    iget-object v1, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->m_map:[B

    if-nez v1, :cond_1

    .line 1318
    const-string v11, ""

    .restart local v11    # "result":Ljava/lang/CharSequence;
    goto :goto_0

    .line 1322
    .end local v11    # "result":Ljava/lang/CharSequence;
    :cond_1
    const/4 v10, 0x1

    .line 1323
    .local v10, "keepOriginal":Z
    new-instance v12, Ljava/lang/StringBuffer;

    sub-int v1, p3, p2

    invoke-direct {v12, v1}, Ljava/lang/StringBuffer;-><init>(I)V

    .line 1324
    .local v12, "sb":Ljava/lang/StringBuffer;
    move/from16 v13, p2

    .line 1327
    .local v13, "start_index":I
    sub-int v1, p3, p2

    const/4 v2, 0x1

    if-le v1, v2, :cond_3

    .line 1329
    const/4 v9, 0x0

    .line 1330
    .local v9, "index":I
    :goto_2
    add-int v1, p2, v9

    move/from16 v0, p3

    if-ge v1, v0, :cond_2

    add-int v1, p5, v9

    move/from16 v0, p6

    if-ge v1, v0, :cond_2

    .line 1332
    add-int v1, p2, v9

    invoke-interface {p1, v1}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v1

    add-int v2, p5, v9

    move-object/from16 v0, p4

    invoke-interface {v0, v2}, Landroid/text/Spanned;->charAt(I)C

    move-result v2

    if-ne v1, v2, :cond_2

    .line 1334
    add-int v1, p2, v9

    invoke-interface {p1, v1}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v1

    invoke-virtual {v12, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 1335
    add-int/lit8 v9, v9, 0x1

    goto :goto_2

    .line 1342
    :cond_2
    add-int v13, p2, v9

    .line 1345
    .end local v9    # "index":I
    :cond_3
    move v8, v13

    .local v8, "i":I
    :goto_3
    move/from16 v0, p3

    if-ge v8, v0, :cond_5

    .line 1347
    invoke-interface {p1, v8}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v7

    .line 1348
    .local v7, "code":C
    invoke-virtual {p0, v7}, Lcom/adobe/air/AndroidStageText$RestrictFilter;->IsCharAvailable(C)Z

    move-result v1

    if-nez v1, :cond_4

    .line 1350
    const/4 v10, 0x0

    .line 1345
    :goto_4
    add-int/lit8 v8, v8, 0x1

    goto :goto_3

    .line 1354
    :cond_4
    invoke-virtual {v12, v7}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    goto :goto_4

    .line 1358
    .end local v7    # "code":C
    :cond_5
    if-eqz v10, :cond_6

    .line 1360
    const/4 v5, 0x0

    goto :goto_1

    .line 1364
    :cond_6
    instance-of v1, p1, Landroid/text/Spanned;

    if-eqz v1, :cond_7

    .line 1366
    new-instance v5, Landroid/text/SpannableString;

    invoke-direct {v5, v12}, Landroid/text/SpannableString;-><init>(Ljava/lang/CharSequence;)V

    .local v5, "sp":Landroid/text/SpannableString;
    move-object v1, p1

    .line 1367
    check-cast v1, Landroid/text/Spanned;

    invoke-virtual {v12}, Ljava/lang/StringBuffer;->length()I

    move-result v3

    const/4 v4, 0x0

    const/4 v6, 0x0

    move/from16 v2, p2

    invoke-static/range {v1 .. v6}, Landroid/text/TextUtils;->copySpansFrom(Landroid/text/Spanned;IILjava/lang/Class;Landroid/text/Spannable;I)V

    goto :goto_1

    .end local v5    # "sp":Landroid/text/SpannableString;
    :cond_7
    move-object v5, v12

    .line 1372
    goto :goto_1
.end method

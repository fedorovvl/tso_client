.class public Lcom/adobe/air/utils/CharsetUtils;
.super Ljava/lang/Object;
.source "CharsetUtils.java"


# static fields
.field public static final EMPTY_BARRAY:[B

.field public static final EMPTY_CARRAY:[C

.field public static final LOG_TAG:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 40
    const-class v0, Lcom/adobe/air/utils/CharsetUtils;

    invoke-virtual {v0}, Ljava/lang/Class;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/adobe/air/utils/CharsetUtils;->LOG_TAG:Ljava/lang/String;

    .line 48
    new-array v0, v1, [C

    sput-object v0, Lcom/adobe/air/utils/CharsetUtils;->EMPTY_CARRAY:[C

    .line 49
    new-array v0, v1, [B

    sput-object v0, Lcom/adobe/air/utils/CharsetUtils;->EMPTY_BARRAY:[B

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 38
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static ConvertMBCStoUTF16([BLjava/lang/String;)[B
    .locals 5
    .param p0, "mbcs"    # [B
    .param p1, "charsetName"    # Ljava/lang/String;

    .prologue
    .line 110
    :try_start_0
    invoke-static {p0, p1}, Lcom/adobe/air/utils/CharsetUtils;->DecodeBuffer([BLjava/lang/String;)Ljava/nio/CharBuffer;

    move-result-object v1

    .line 112
    .local v1, "cbuf":Ljava/nio/CharBuffer;
    const-string v4, "UTF-16LE"

    invoke-static {v4}, Ljava/nio/charset/Charset;->forName(Ljava/lang/String;)Ljava/nio/charset/Charset;

    move-result-object v2

    .line 113
    .local v2, "dst":Ljava/nio/charset/Charset;
    invoke-virtual {v2, v1}, Ljava/nio/charset/Charset;->encode(Ljava/nio/CharBuffer;)Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 115
    .local v0, "bbuf":Ljava/nio/ByteBuffer;
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->array()[B
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v4

    .line 119
    .end local v0    # "bbuf":Ljava/nio/ByteBuffer;
    .end local v1    # "cbuf":Ljava/nio/CharBuffer;
    .end local v2    # "dst":Ljava/nio/charset/Charset;
    :goto_0
    return-object v4

    .line 117
    :catch_0
    move-exception v3

    .line 119
    .local v3, "err":Ljava/lang/Exception;
    sget-object v4, Lcom/adobe/air/utils/CharsetUtils;->EMPTY_BARRAY:[B

    goto :goto_0
.end method

.method public static ConvertMBCStoUTF8([BLjava/lang/String;)[B
    .locals 7
    .param p0, "mbcs"    # [B
    .param p1, "charsetName"    # Ljava/lang/String;

    .prologue
    .line 166
    :try_start_0
    invoke-static {p0, p1}, Lcom/adobe/air/utils/CharsetUtils;->DecodeBuffer([BLjava/lang/String;)Ljava/nio/CharBuffer;

    move-result-object v1

    .line 168
    .local v1, "cbuf":Ljava/nio/CharBuffer;
    const-string v6, "UTF-8"

    invoke-static {v6}, Ljava/nio/charset/Charset;->forName(Ljava/lang/String;)Ljava/nio/charset/Charset;

    move-result-object v2

    .line 169
    .local v2, "dst":Ljava/nio/charset/Charset;
    invoke-virtual {v2}, Ljava/nio/charset/Charset;->newEncoder()Ljava/nio/charset/CharsetEncoder;

    move-result-object v3

    .line 170
    .local v3, "encoder":Ljava/nio/charset/CharsetEncoder;
    invoke-virtual {v3, v1}, Ljava/nio/charset/CharsetEncoder;->encode(Ljava/nio/CharBuffer;)Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 171
    .local v0, "bbuf":Ljava/nio/ByteBuffer;
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->array()[B
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v5

    .line 178
    .end local v0    # "bbuf":Ljava/nio/ByteBuffer;
    .end local v1    # "cbuf":Ljava/nio/CharBuffer;
    .end local v2    # "dst":Ljava/nio/charset/Charset;
    .end local v3    # "encoder":Ljava/nio/charset/CharsetEncoder;
    :goto_0
    return-object v5

    .line 173
    :catch_0
    move-exception v4

    .line 175
    .local v4, "err":Ljava/lang/Exception;
    sget-object v5, Lcom/adobe/air/utils/CharsetUtils;->EMPTY_BARRAY:[B

    goto :goto_0
.end method

.method public static ConvertUTF16toMBCS([BLjava/lang/String;)[B
    .locals 6
    .param p0, "utf16"    # [B
    .param p1, "charsetName"    # Ljava/lang/String;

    .prologue
    .line 126
    :try_start_0
    const-string v5, "UTF-16LE"

    invoke-static {p0, v5}, Lcom/adobe/air/utils/CharsetUtils;->DecodeBuffer([BLjava/lang/String;)Ljava/nio/CharBuffer;

    move-result-object v1

    .line 128
    .local v1, "cbuf":Ljava/nio/CharBuffer;
    invoke-static {p1}, Ljava/nio/charset/Charset;->forName(Ljava/lang/String;)Ljava/nio/charset/Charset;

    move-result-object v2

    .line 129
    .local v2, "dst":Ljava/nio/charset/Charset;
    invoke-virtual {v2}, Ljava/nio/charset/Charset;->newEncoder()Ljava/nio/charset/CharsetEncoder;

    move-result-object v3

    .line 130
    .local v3, "encoder":Ljava/nio/charset/CharsetEncoder;
    sget-object v5, Ljava/nio/charset/CodingErrorAction;->REPLACE:Ljava/nio/charset/CodingErrorAction;

    invoke-virtual {v3, v5}, Ljava/nio/charset/CharsetEncoder;->onUnmappableCharacter(Ljava/nio/charset/CodingErrorAction;)Ljava/nio/charset/CharsetEncoder;

    .line 131
    invoke-virtual {v3, v1}, Ljava/nio/charset/CharsetEncoder;->encode(Ljava/nio/CharBuffer;)Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 133
    .local v0, "bbuf":Ljava/nio/ByteBuffer;
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->array()[B
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v5

    .line 136
    .end local v0    # "bbuf":Ljava/nio/ByteBuffer;
    .end local v1    # "cbuf":Ljava/nio/CharBuffer;
    .end local v2    # "dst":Ljava/nio/charset/Charset;
    .end local v3    # "encoder":Ljava/nio/charset/CharsetEncoder;
    :goto_0
    return-object v5

    .line 134
    :catch_0
    move-exception v4

    .line 136
    .local v4, "err":Ljava/lang/Exception;
    sget-object v5, Lcom/adobe/air/utils/CharsetUtils;->EMPTY_BARRAY:[B

    goto :goto_0
.end method

.method public static ConvertUTF8toMBCS([BLjava/lang/String;)[B
    .locals 7
    .param p0, "utf8"    # [B
    .param p1, "charsetName"    # Ljava/lang/String;

    .prologue
    .line 145
    :try_start_0
    const-string v6, "UTF-8"

    invoke-static {p0, v6}, Lcom/adobe/air/utils/CharsetUtils;->DecodeBuffer([BLjava/lang/String;)Ljava/nio/CharBuffer;

    move-result-object v1

    .line 147
    .local v1, "cbuf":Ljava/nio/CharBuffer;
    invoke-static {p1}, Ljava/nio/charset/Charset;->forName(Ljava/lang/String;)Ljava/nio/charset/Charset;

    move-result-object v2

    .line 148
    .local v2, "dst":Ljava/nio/charset/Charset;
    invoke-virtual {v2}, Ljava/nio/charset/Charset;->newEncoder()Ljava/nio/charset/CharsetEncoder;

    move-result-object v3

    .line 149
    .local v3, "encoder":Ljava/nio/charset/CharsetEncoder;
    sget-object v6, Ljava/nio/charset/CodingErrorAction;->REPLACE:Ljava/nio/charset/CodingErrorAction;

    invoke-virtual {v3, v6}, Ljava/nio/charset/CharsetEncoder;->onUnmappableCharacter(Ljava/nio/charset/CodingErrorAction;)Ljava/nio/charset/CharsetEncoder;

    .line 150
    invoke-virtual {v3, v1}, Ljava/nio/charset/CharsetEncoder;->encode(Ljava/nio/CharBuffer;)Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 151
    .local v0, "bbuf":Ljava/nio/ByteBuffer;
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->array()[B
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v5

    .line 158
    .end local v0    # "bbuf":Ljava/nio/ByteBuffer;
    .end local v1    # "cbuf":Ljava/nio/CharBuffer;
    .end local v2    # "dst":Ljava/nio/charset/Charset;
    .end local v3    # "encoder":Ljava/nio/charset/CharsetEncoder;
    :goto_0
    return-object v5

    .line 153
    :catch_0
    move-exception v4

    .line 155
    .local v4, "err":Ljava/lang/Exception;
    sget-object v5, Lcom/adobe/air/utils/CharsetUtils;->EMPTY_BARRAY:[B

    goto :goto_0
.end method

.method public static DecodeBuffer([BLjava/lang/String;)Ljava/nio/CharBuffer;
    .locals 3
    .param p0, "buf"    # [B
    .param p1, "charsetName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/nio/charset/CharacterCodingException;
        }
    .end annotation

    .prologue
    .line 101
    invoke-static {p1}, Ljava/nio/charset/Charset;->forName(Ljava/lang/String;)Ljava/nio/charset/Charset;

    move-result-object v1

    .line 102
    .local v1, "src":Ljava/nio/charset/Charset;
    invoke-virtual {v1}, Ljava/nio/charset/Charset;->newDecoder()Ljava/nio/charset/CharsetDecoder;

    move-result-object v0

    .line 103
    .local v0, "decoder":Ljava/nio/charset/CharsetDecoder;
    sget-object v2, Ljava/nio/charset/CodingErrorAction;->REPLACE:Ljava/nio/charset/CodingErrorAction;

    invoke-virtual {v0, v2}, Ljava/nio/charset/CharsetDecoder;->onUnmappableCharacter(Ljava/nio/charset/CodingErrorAction;)Ljava/nio/charset/CharsetDecoder;

    .line 104
    invoke-static {p0}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/nio/charset/CharsetDecoder;->decode(Ljava/nio/ByteBuffer;)Ljava/nio/CharBuffer;

    move-result-object v2

    return-object v2
.end method

.method public static QueryAvailableCharsets()Ljava/lang/String;
    .locals 6

    .prologue
    .line 183
    const-string v0, ""

    .line 184
    .local v0, "allCharsets":Ljava/lang/String;
    invoke-static {}, Ljava/nio/charset/Charset;->availableCharsets()Ljava/util/SortedMap;

    move-result-object v1

    .line 185
    .local v1, "charsetsMap":Ljava/util/SortedMap;, "Ljava/util/SortedMap<Ljava/lang/String;Ljava/nio/charset/Charset;>;"
    invoke-interface {v1}, Ljava/util/SortedMap;->keySet()Ljava/util/Set;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .line 186
    .local v2, "iter":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/lang/String;>;"
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_0

    .line 187
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 188
    .local v3, "name":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 189
    goto :goto_0

    .line 190
    .end local v3    # "name":Ljava/lang/String;
    :cond_0
    return-object v0
.end method

.method public static mbcsToUtf16([B)[C
    .locals 6
    .param p0, "mbcsBuf"    # [B

    .prologue
    .line 75
    :try_start_0
    const-string v5, "ISO-8859-1"

    invoke-static {v5}, Ljava/nio/charset/Charset;->forName(Ljava/lang/String;)Ljava/nio/charset/Charset;

    move-result-object v3

    .line 76
    .local v3, "src":Ljava/nio/charset/Charset;
    invoke-virtual {v3}, Ljava/nio/charset/Charset;->newDecoder()Ljava/nio/charset/CharsetDecoder;

    move-result-object v1

    .line 78
    .local v1, "dec":Ljava/nio/charset/CharsetDecoder;
    invoke-static {p0}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v5

    invoke-virtual {v1, v5}, Ljava/nio/charset/CharsetDecoder;->decode(Ljava/nio/ByteBuffer;)Ljava/nio/CharBuffer;

    move-result-object v0

    .line 79
    .local v0, "buf":Ljava/nio/CharBuffer;
    invoke-virtual {v0}, Ljava/nio/CharBuffer;->array()[C
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v4

    .line 85
    .local v4, "utf16Buf":[C
    if-nez v4, :cond_0

    .line 86
    sget-object v4, Lcom/adobe/air/utils/CharsetUtils;->EMPTY_CARRAY:[C

    .line 88
    .end local v0    # "buf":Ljava/nio/CharBuffer;
    .end local v1    # "dec":Ljava/nio/charset/CharsetDecoder;
    .end local v3    # "src":Ljava/nio/charset/Charset;
    .end local v4    # "utf16Buf":[C
    :cond_0
    :goto_0
    return-object v4

    .line 80
    :catch_0
    move-exception v2

    .line 82
    .local v2, "err":Ljava/lang/Exception;
    sget-object v4, Lcom/adobe/air/utils/CharsetUtils;->EMPTY_CARRAY:[C

    goto :goto_0
.end method

.method public static mbcsToUtf8([B)[B
    .locals 2
    .param p0, "mbcsBuf"    # [B

    .prologue
    .line 92
    invoke-static {p0}, Lcom/adobe/air/utils/CharsetUtils;->mbcsToUtf16([B)[C

    move-result-object v0

    .line 93
    .local v0, "utf16Buf":[C
    invoke-static {v0}, Lcom/adobe/air/utils/CharsetUtils;->utf16ToUtf8([C)[B

    move-result-object v1

    .line 95
    .local v1, "utf8Buf":[B
    return-object v1
.end method

.method public static utf16ToUtf8([C)[B
    .locals 6
    .param p0, "utf16Buf"    # [C

    .prologue
    .line 55
    :try_start_0
    const-string v5, "UTF-8"

    invoke-static {v5}, Ljava/nio/charset/Charset;->forName(Ljava/lang/String;)Ljava/nio/charset/Charset;

    move-result-object v1

    .line 56
    .local v1, "dst":Ljava/nio/charset/Charset;
    invoke-virtual {v1}, Ljava/nio/charset/Charset;->newEncoder()Ljava/nio/charset/CharsetEncoder;

    move-result-object v2

    .line 58
    .local v2, "enc":Ljava/nio/charset/CharsetEncoder;
    invoke-static {p0}, Ljava/nio/CharBuffer;->wrap([C)Ljava/nio/CharBuffer;

    move-result-object v5

    invoke-virtual {v2, v5}, Ljava/nio/charset/CharsetEncoder;->encode(Ljava/nio/CharBuffer;)Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 59
    .local v0, "buf":Ljava/nio/ByteBuffer;
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->array()[B
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v4

    .line 65
    .local v4, "utf8Buf":[B
    if-nez v4, :cond_0

    .line 66
    sget-object v4, Lcom/adobe/air/utils/CharsetUtils;->EMPTY_BARRAY:[B

    .line 68
    .end local v0    # "buf":Ljava/nio/ByteBuffer;
    .end local v1    # "dst":Ljava/nio/charset/Charset;
    .end local v2    # "enc":Ljava/nio/charset/CharsetEncoder;
    .end local v4    # "utf8Buf":[B
    :cond_0
    :goto_0
    return-object v4

    .line 60
    :catch_0
    move-exception v3

    .line 62
    .local v3, "err":Ljava/lang/Exception;
    sget-object v4, Lcom/adobe/air/utils/CharsetUtils;->EMPTY_BARRAY:[B

    goto :goto_0
.end method

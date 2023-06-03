.class public final enum Lcom/adobe/air/wand/message/Message$Type;
.super Ljava/lang/Enum;
.source "Message.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/wand/message/Message;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "Type"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/adobe/air/wand/message/Message$Type;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/adobe/air/wand/message/Message$Type;

.field public static final enum NOTIFICATION:Lcom/adobe/air/wand/message/Message$Type;

.field public static final enum REQUEST:Lcom/adobe/air/wand/message/Message$Type;

.field public static final enum RESPONSE:Lcom/adobe/air/wand/message/Message$Type;


# instance fields
.field private final mType:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 6

    .prologue
    const/4 v5, 0x2

    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 28
    new-instance v0, Lcom/adobe/air/wand/message/Message$Type;

    const-string v1, "REQUEST"

    const-string v2, "REQUEST"

    invoke-direct {v0, v1, v3, v2}, Lcom/adobe/air/wand/message/Message$Type;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/adobe/air/wand/message/Message$Type;->REQUEST:Lcom/adobe/air/wand/message/Message$Type;

    .line 29
    new-instance v0, Lcom/adobe/air/wand/message/Message$Type;

    const-string v1, "RESPONSE"

    const-string v2, "RESPONSE"

    invoke-direct {v0, v1, v4, v2}, Lcom/adobe/air/wand/message/Message$Type;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/adobe/air/wand/message/Message$Type;->RESPONSE:Lcom/adobe/air/wand/message/Message$Type;

    .line 30
    new-instance v0, Lcom/adobe/air/wand/message/Message$Type;

    const-string v1, "NOTIFICATION"

    const-string v2, "NOTIFICATION"

    invoke-direct {v0, v1, v5, v2}, Lcom/adobe/air/wand/message/Message$Type;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/adobe/air/wand/message/Message$Type;->NOTIFICATION:Lcom/adobe/air/wand/message/Message$Type;

    .line 27
    const/4 v0, 0x3

    new-array v0, v0, [Lcom/adobe/air/wand/message/Message$Type;

    sget-object v1, Lcom/adobe/air/wand/message/Message$Type;->REQUEST:Lcom/adobe/air/wand/message/Message$Type;

    aput-object v1, v0, v3

    sget-object v1, Lcom/adobe/air/wand/message/Message$Type;->RESPONSE:Lcom/adobe/air/wand/message/Message$Type;

    aput-object v1, v0, v4

    sget-object v1, Lcom/adobe/air/wand/message/Message$Type;->NOTIFICATION:Lcom/adobe/air/wand/message/Message$Type;

    aput-object v1, v0, v5

    sput-object v0, Lcom/adobe/air/wand/message/Message$Type;->$VALUES:[Lcom/adobe/air/wand/message/Message$Type;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0
    .param p3, "type"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .line 34
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 35
    iput-object p3, p0, Lcom/adobe/air/wand/message/Message$Type;->mType:Ljava/lang/String;

    .line 36
    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/adobe/air/wand/message/Message$Type;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 27
    const-class v0, Lcom/adobe/air/wand/message/Message$Type;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/adobe/air/wand/message/Message$Type;

    return-object v0
.end method

.method public static values()[Lcom/adobe/air/wand/message/Message$Type;
    .locals 1

    .prologue
    .line 27
    sget-object v0, Lcom/adobe/air/wand/message/Message$Type;->$VALUES:[Lcom/adobe/air/wand/message/Message$Type;

    invoke-virtual {v0}, [Lcom/adobe/air/wand/message/Message$Type;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/adobe/air/wand/message/Message$Type;

    return-object v0
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 1

    .prologue
    .line 40
    iget-object v0, p0, Lcom/adobe/air/wand/message/Message$Type;->mType:Ljava/lang/String;

    return-object v0
.end method

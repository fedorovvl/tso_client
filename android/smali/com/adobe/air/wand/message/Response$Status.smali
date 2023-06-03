.class public final enum Lcom/adobe/air/wand/message/Response$Status;
.super Ljava/lang/Enum;
.source "Response.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/wand/message/Response;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "Status"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/adobe/air/wand/message/Response$Status;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/adobe/air/wand/message/Response$Status;

.field public static final enum ERROR:Lcom/adobe/air/wand/message/Response$Status;

.field public static final enum SUCCESS:Lcom/adobe/air/wand/message/Response$Status;


# instance fields
.field private final mStatus:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .prologue
    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 28
    new-instance v0, Lcom/adobe/air/wand/message/Response$Status;

    const-string v1, "SUCCESS"

    const-string v2, "SUCCESS"

    invoke-direct {v0, v1, v3, v2}, Lcom/adobe/air/wand/message/Response$Status;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/adobe/air/wand/message/Response$Status;->SUCCESS:Lcom/adobe/air/wand/message/Response$Status;

    .line 29
    new-instance v0, Lcom/adobe/air/wand/message/Response$Status;

    const-string v1, "ERROR"

    const-string v2, "ERROR"

    invoke-direct {v0, v1, v4, v2}, Lcom/adobe/air/wand/message/Response$Status;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/adobe/air/wand/message/Response$Status;->ERROR:Lcom/adobe/air/wand/message/Response$Status;

    .line 27
    const/4 v0, 0x2

    new-array v0, v0, [Lcom/adobe/air/wand/message/Response$Status;

    sget-object v1, Lcom/adobe/air/wand/message/Response$Status;->SUCCESS:Lcom/adobe/air/wand/message/Response$Status;

    aput-object v1, v0, v3

    sget-object v1, Lcom/adobe/air/wand/message/Response$Status;->ERROR:Lcom/adobe/air/wand/message/Response$Status;

    aput-object v1, v0, v4

    sput-object v0, Lcom/adobe/air/wand/message/Response$Status;->$VALUES:[Lcom/adobe/air/wand/message/Response$Status;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0
    .param p3, "status"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .line 31
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 32
    iput-object p3, p0, Lcom/adobe/air/wand/message/Response$Status;->mStatus:Ljava/lang/String;

    .line 33
    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/adobe/air/wand/message/Response$Status;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 27
    const-class v0, Lcom/adobe/air/wand/message/Response$Status;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/adobe/air/wand/message/Response$Status;

    return-object v0
.end method

.method public static values()[Lcom/adobe/air/wand/message/Response$Status;
    .locals 1

    .prologue
    .line 27
    sget-object v0, Lcom/adobe/air/wand/message/Response$Status;->$VALUES:[Lcom/adobe/air/wand/message/Response$Status;

    invoke-virtual {v0}, [Lcom/adobe/air/wand/message/Response$Status;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/adobe/air/wand/message/Response$Status;

    return-object v0
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 1

    .prologue
    .line 39
    iget-object v0, p0, Lcom/adobe/air/wand/message/Response$Status;->mStatus:Ljava/lang/String;

    return-object v0
.end method

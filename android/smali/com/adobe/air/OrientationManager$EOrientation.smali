.class public final enum Lcom/adobe/air/OrientationManager$EOrientation;
.super Ljava/lang/Enum;
.source "OrientationManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/OrientationManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "EOrientation"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/adobe/air/OrientationManager$EOrientation;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/adobe/air/OrientationManager$EOrientation;

.field public static final enum DEFAULT:Lcom/adobe/air/OrientationManager$EOrientation;

.field public static final enum ROTATED_LEFT:Lcom/adobe/air/OrientationManager$EOrientation;

.field public static final enum ROTATED_RIGHT:Lcom/adobe/air/OrientationManager$EOrientation;

.field public static final enum UNKNOWN:Lcom/adobe/air/OrientationManager$EOrientation;

.field public static final enum UPSIDE_DOWN:Lcom/adobe/air/OrientationManager$EOrientation;


# direct methods
.method static constructor <clinit>()V
    .locals 7

    .prologue
    const/4 v6, 0x4

    const/4 v5, 0x3

    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 43
    new-instance v0, Lcom/adobe/air/OrientationManager$EOrientation;

    const-string v1, "UNKNOWN"

    invoke-direct {v0, v1, v2}, Lcom/adobe/air/OrientationManager$EOrientation;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/OrientationManager$EOrientation;->UNKNOWN:Lcom/adobe/air/OrientationManager$EOrientation;

    new-instance v0, Lcom/adobe/air/OrientationManager$EOrientation;

    const-string v1, "DEFAULT"

    invoke-direct {v0, v1, v3}, Lcom/adobe/air/OrientationManager$EOrientation;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/OrientationManager$EOrientation;->DEFAULT:Lcom/adobe/air/OrientationManager$EOrientation;

    new-instance v0, Lcom/adobe/air/OrientationManager$EOrientation;

    const-string v1, "ROTATED_LEFT"

    invoke-direct {v0, v1, v4}, Lcom/adobe/air/OrientationManager$EOrientation;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/OrientationManager$EOrientation;->ROTATED_LEFT:Lcom/adobe/air/OrientationManager$EOrientation;

    new-instance v0, Lcom/adobe/air/OrientationManager$EOrientation;

    const-string v1, "ROTATED_RIGHT"

    invoke-direct {v0, v1, v5}, Lcom/adobe/air/OrientationManager$EOrientation;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/OrientationManager$EOrientation;->ROTATED_RIGHT:Lcom/adobe/air/OrientationManager$EOrientation;

    new-instance v0, Lcom/adobe/air/OrientationManager$EOrientation;

    const-string v1, "UPSIDE_DOWN"

    invoke-direct {v0, v1, v6}, Lcom/adobe/air/OrientationManager$EOrientation;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/OrientationManager$EOrientation;->UPSIDE_DOWN:Lcom/adobe/air/OrientationManager$EOrientation;

    const/4 v0, 0x5

    new-array v0, v0, [Lcom/adobe/air/OrientationManager$EOrientation;

    sget-object v1, Lcom/adobe/air/OrientationManager$EOrientation;->UNKNOWN:Lcom/adobe/air/OrientationManager$EOrientation;

    aput-object v1, v0, v2

    sget-object v1, Lcom/adobe/air/OrientationManager$EOrientation;->DEFAULT:Lcom/adobe/air/OrientationManager$EOrientation;

    aput-object v1, v0, v3

    sget-object v1, Lcom/adobe/air/OrientationManager$EOrientation;->ROTATED_LEFT:Lcom/adobe/air/OrientationManager$EOrientation;

    aput-object v1, v0, v4

    sget-object v1, Lcom/adobe/air/OrientationManager$EOrientation;->ROTATED_RIGHT:Lcom/adobe/air/OrientationManager$EOrientation;

    aput-object v1, v0, v5

    sget-object v1, Lcom/adobe/air/OrientationManager$EOrientation;->UPSIDE_DOWN:Lcom/adobe/air/OrientationManager$EOrientation;

    aput-object v1, v0, v6

    sput-object v0, Lcom/adobe/air/OrientationManager$EOrientation;->$VALUES:[Lcom/adobe/air/OrientationManager$EOrientation;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 43
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/adobe/air/OrientationManager$EOrientation;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 43
    const-class v0, Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/adobe/air/OrientationManager$EOrientation;

    return-object v0
.end method

.method public static values()[Lcom/adobe/air/OrientationManager$EOrientation;
    .locals 1

    .prologue
    .line 43
    sget-object v0, Lcom/adobe/air/OrientationManager$EOrientation;->$VALUES:[Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v0}, [Lcom/adobe/air/OrientationManager$EOrientation;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/adobe/air/OrientationManager$EOrientation;

    return-object v0
.end method
